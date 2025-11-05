INSERT INTO customer VALUES
(1301, 'satoshi.tanaka', 'satoshi.tanaka@example.com', '+81-3-1111-1111', 'Chuo-dori, Tokyo', 'JP'),
(1302, 'yuki.suzuki', 'yuki.suzuki@example.com', '+81-3-2222-2222', 'Shibuya, Tokyo', 'JP'),
(1303, 'minjun.park', 'minjun.park@example.com', '+82-2-333-3333', 'Mapo-gu, Seoul', 'KR'),
(1304, 'wei.chen', 'wei.chen@example.com', '+886-2-4444-4444', 'Xinyi, Taipei', 'TW'),
(1305, 'arisa.nakamura', 'arisa.nakamura@example.com', '+81-45-555-5555', 'Yokohama', 'JP');

INSERT INTO seller VALUES
(3301, 'Tokyo Tools', 'JP', 4.4),
(3302, 'Seoul Sound', 'KR', 4.6),
(3303, 'Taipei Toys', 'TW', 4.2),
(3304, 'Bangkok Kitchen', 'TH', 4.0),
(3305, 'Hanoi Fashion', 'VN', 4.1);

INSERT INTO product (product_id, seller_id, sku, title, category, price, active) VALUES
(2301, 3301, 'TKT-DRILL', 'Compact Drill', 'Tools', 88.00, TRUE),
(2302, 3302, 'SES-EARBUD', 'ANC Earbuds', 'Audio', 129.00, TRUE),
(2303, 3303, 'TPT-ROBOT', 'Mini Robot Kit', 'Toys', 39.00, TRUE),
(2304, 3304, 'BKK-WOK', 'Carbon Steel Wok', 'Kitchen', 52.00, TRUE),
(2305, 3305, 'HNF-SCARF', 'Silk Scarf', 'Apparel', 35.00, TRUE);

INSERT INTO order_header VALUES
(5301, 1301, '2025-04-01 09:00:00', 'paid', 88.00),
(5302, 1302, '2025-04-02 10:15:00', 'paid', 129.00),
(5303, 1303, '2025-04-03 16:40:00', 'paid', 39.00),
(5304, 1304, '2025-04-04 17:00:00', 'processing', 52.00),
(5305, 1305, '2025-04-05 19:30:00', 'paid', 35.00);

INSERT INTO order_item VALUES
(6301, 5301, 2301, 1, 88.00, 0),
(6302, 5302, 2302, 1, 129.00, 0),
(6303, 5303, 2303, 1, 39.00, 0),
(6304, 5304, 2304, 1, 52.00, 0),
(6305, 5305, 2305, 1, 35.00, 0);