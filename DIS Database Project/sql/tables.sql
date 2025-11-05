CREATE TABLE IF NOT EXISTS public.customer (
  customer_id INT PRIMARY KEY,
  username TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT,
  address TEXT,
  country TEXT
);

CREATE TABLE IF NOT EXISTS public.seller (
  seller_id INT PRIMARY KEY,
  name TEXT NOT NULL,
  country TEXT,
  rating NUMERIC(2,1)
);

CREATE TABLE IF NOT EXISTS public.product (
  product_id INT PRIMARY KEY,
  seller_id INT NOT NULL REFERENCES public.seller(seller_id),
  sku TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  category TEXT,
  price NUMERIC(10,2) NOT NULL,
  active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.order_header (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES public.customer(customer_id),
  order_date TIMESTAMP NOT NULL,
  status TEXT NOT NULL,
  total NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.order_item (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL REFERENCES public.order_header(order_id),
  product_id INT NOT NULL REFERENCES public.product(product_id),
  qty INT NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL,
  discount NUMERIC(5,2) DEFAULT 0
);