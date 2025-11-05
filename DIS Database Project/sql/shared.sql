INSERT INTO public.customer (customer_id, username, email, phone, address, country) VALUES
(1001, 'alice.andersson', 'alice.andersson@example.com', '+46-70-1111111', 'Sveavägen 1, Stockholm', 'SE'),
(1002, 'bob.brown', 'bob.brown@example.com', '+1-614-2222222', '200 High St, Columbus, OH', 'US'),
(1003, 'chen.li', 'chen.li@example.com', '+86-10-33333333', 'Chaoyang, Beijing', 'CN'),
(1004, 'diana.fischer', 'diana.fischer@example.com', '+49-69-444444', 'Zeil 10, Frankfurt', 'DE'),
(1005, 'ethan.kim', 'ethan.kim@example.com', '+82-2-555555', 'Gangnam-daero, Seoul', 'KR');

INSERT INTO public.seller (seller_id, name, country, rating) VALUES
(3001, 'Acme Gadgets', 'US', 4.6),
(3002, 'Nordic Tech', 'SE', 4.5),
(3003, 'EuroStyle', 'DE', 4.2),
(3004, 'Samurai Electronics', 'JP', 4.7),
(3005, 'Global Home', 'NL', 4.0);

INSERT INTO public.product (product_id, seller_id, sku, title, category, price, active) VALUES
(2001, 3001, 'ACM-USB-CAB', 'USB-C Cable 1m', 'Accessories', 9.99, TRUE),
(2002, 3002, 'NTK-MOUSE', 'Wireless Mouse', 'Peripherals', 24.90, TRUE),
(2003, 3003, 'EST-KETTLE', 'Electric Kettle', 'Home', 39.50, TRUE),
(2004, 3004, 'SAMR-HEADPH', 'On-Ear Headphones', 'Audio', 59.00, TRUE),
(2005, 3005, 'GLB-NOTEBOOK', 'A5 Notebook', 'Stationery', 3.25, TRUE);

INSERT INTO public.order_header (order_id, customer_id, order_date, status, total) VALUES
(5001, 1001, '2025-01-10 10:00:00', 'paid', 9.99),
(5002, 1002, '2025-01-11 11:00:00', 'paid', 24.90),
(5003, 1003, '2025-01-12 12:30:00', 'paid', 39.50),
(5004, 1004, '2025-01-13 13:00:00', 'shipped', 59.00),
(5005, 1005, '2025-01-14 15:15:00', 'paid', 3.25);

INSERT INTO public.order_item (order_item_id, order_id, product_id, qty, unit_price, discount) VALUES
(6001, 5001, 2001, 1, 9.99, 0),
(6002, 5002, 2002, 1, 24.90, 0),
(6003, 5003, 2003, 1, 39.50, 0),
(6004, 5004, 2004, 1, 59.00, 0),
(6005, 5005, 2005, 1, 3.25, 0);