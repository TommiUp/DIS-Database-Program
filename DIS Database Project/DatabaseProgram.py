import psycopg2
from psycopg2.extras import RealDictCursor
import os  # Used to build paths to the sql/ files
from dotenv import load_dotenv
load_dotenv()  # Loads variables from .env

# Postgre login credentials, port usually stays the same but password needs to be changed to own postgre password in .env file
PG_USER = os.getenv("PG_USER", "postgres")
PG_PASSWORD = os.getenv("PG_PASSWORD")  # CHANGE IN .ENV FILE
PG_HOST = os.getenv("PG_HOST", "localhost")
PG_PORT = int(os.getenv("PG_PORT", "5432"))

# Three different databases as regions
REGIONS = {
    "frankfurt": {"dbname": "store_frankfurt"},
    "ohio": {"dbname": "store_ohio"},
    "tokyo": {"dbname": "store_tokyo"},
}

# Tables and their primary keys
TABLES = ["customer", "seller", "product", "order_header", "order_item"]
PK = {
    "customer": "customer_id",
    "seller": "seller_id",
    "product": "product_id",
    "order_header": "order_id",
    "order_item": "order_item_id",
}

# Paths to the SQL files inside ./sql/ for restoring databases
baseDir = os.path.dirname(os.path.abspath(__file__))
sqlDir = os.path.join(baseDir, "sql")

# Connects to the selected region/database. Opens and returns a psycopg2 connection to the db for the selected region
def connect(regionKey):
    cfg = REGIONS[regionKey]
    return psycopg2.connect(
        dbname=cfg["dbname"],
        user=PG_USER,
        password=PG_PASSWORD,
        host=PG_HOST,
        port=PG_PORT,
    )

# Runs a SELECT query and returns all rows as dicts with the column -> value
def fetchRows(conn, sql, params=None):
    with conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(sql, params or [])
        return cur.fetchall()

# Returns the column names for the selected table in the same order as in schema in postgresql
def getColumns(conn, table):
    sql = """
      SELECT column_name
      FROM information_schema.columns
      WHERE table_schema='public' AND table_name=%s
      ORDER BY ordinal_position
    """
    with conn.cursor() as cur:
        cur.execute(sql, (table,))
        return [r[0] for r in cur.fetchall()]

# Read a sql file from disk and executes its contents. This is for creating tables and restoring
def runSql(conn, filePath):
    with open(filePath, "r", encoding="utf-8") as f:
        sql = f.read()
    with conn:
        with conn.cursor() as cur:
            cur.execute(sql)

# Prints a table with fixed width for every column. The default is set to 10 tables
def printTable(conn, table, limit=10):
    cols = getColumns(conn, table)
    rows = fetchRows(conn, f"SELECT * FROM {table} ORDER BY {PK[table]} LIMIT %s", [limit])
    if not rows:
        print("(no rows)")
        return

    print("\n" + table.upper())
    print("-" * len(table))

    W = 28  # Can be edited if the width is too low
    line = "+" + "+".join("-" * (W + 2) for _ in cols) + "+"

    # Header
    print(line)
    print("|" + "|".join(f" {str(c or ''):<{W}} " for c in cols) + "|")
    print(line)

    # Rows, manually done for the assignment but longer values will exceed the width
    for r in rows:
        print("|" + "|".join(f" {str(r.get(c, '') or ''):<{W}} " for c in cols) + "|")

    print(line)
    print()

# Updates a single column in a table where the primary key equals as 'rowId'
def updateRow(conn, table, rowId, column, value):
    cols = getColumns(conn, table)
    if column not in cols:
        print(f"Column '{column}' not in {table}. Available: {', '.join(cols)}")
        return
    pk = PK[table]
    sql = f"UPDATE {table} SET {column} = %s WHERE {pk} = %s"
    with conn:
        with conn.cursor() as cur:
            cur.execute(sql, (value, rowId))
            if cur.rowcount == 0:
                print("No rows updated (check id).")
            else:
                print(f"Updated {cur.rowcount} row(s).")

# Restores the selected region. First truncates the table, then runs tables.sql + shared.sql + region file (frankfurt, ohio, tokyo)
def restoreDatabase(conn, regionKey):
    # Wipes all data by using the postgresql TRUNCATE feature to quickly clear all rows but keep the tables.
    # The RESTART IDENTITY resets sequences and CASCADE lets TRUNCATE run even with foreign key refs
    truncateSql = """
        TRUNCATE TABLE public.order_item, public.order_header, public.product, public.seller, public.customer
        RESTART IDENTITY CASCADE;
    """
    with conn:
        with conn.cursor() as cur:
            cur.execute(truncateSql)

    # Creates tables if needed
    tablesPath = os.path.join(sqlDir, "tables.sql")
    if os.path.exists(tablesPath):
        runSql(conn, tablesPath)

    # Inserts shared replicated rows
    sharedPath = os.path.join(sqlDir, "shared.sql")
    runSql(conn, sharedPath)

    # Inserts rows for each region (frankfurt, ohio, tokyo)
    regionFile = {"frankfurt": "frankfurt.sql", "ohio": "ohio.sql", "tokyo": "tokyo.sql"}[regionKey]
    regionPath = os.path.join(sqlDir, regionFile)
    runSql(conn, regionPath)
    print(f"Restore complete for region: {regionKey}.")

# Asks the user which region/database to use and returns its key
def chooseRegion():
    while True:
        print("\nSelect region database:")
        for i, k in enumerate(REGIONS.keys(), start=1):
            print(f"{i}) {k}")
        choice = input("Enter number: ").strip()
        mapping = {str(i): k for i, k in enumerate(REGIONS.keys(), start=1)}
        if choice in mapping:
            return mapping[choice]
        print("Invalid choice.")

# Menu loop with options to list/print/update/switch/restore/quit
def menu():
    region = chooseRegion()
    print(f"Connecting to region: {region}")
    conn = connect(region)

    try:
        while True:
            print("\nMenu:")
            print("1) List tables")
            print("2) Print table")
            print("3) Update row")
            print("4) Change region")
            print("5) Restore database (current region)")
            print("6) Quit")
            action = input("Choose: ").strip()

            if action == "1":
                print("Tables:", ", ".join(TABLES))
            elif action == "2":
                table = input(f"Table name {TABLES}: ").strip()
                if table not in TABLES:
                    print("Unknown table.")
                    continue
                try:
                    limit = int(input("Limit (default 10): ") or "10")
                except ValueError:
                    limit = 10
                printTable(conn, table, limit)
            elif action == "3":
                table = input(f"Table name {TABLES}: ").strip()
                if table not in TABLES:
                    print("Unknown table.")
                    continue
                try:
                    rowId = int(input(f"{PK[table]} value: ").strip())
                except ValueError:
                    print("ID must be an integer.")
                    continue
                column = input("Column to update: ").strip()
                value = input("New value: ").strip()
                updateRow(conn, table, rowId, column, value)
            elif action == "4":
                conn.close()
                region = chooseRegion()
                print(f"Connecting to region: {region}")
                conn = connect(region)
            elif action == "5":
                try:
                    restoreDatabase(conn, region)
                except FileNotFoundError as e:
                    print(f"Missing SQL file: {e}")
                except Exception as e:
                    print(f"Restore failed: {e}")
            elif action == "6":
                break
            else:
                print("Invalid option.")
    finally:
        conn.close()

if __name__ == "__main__":
    menu()
