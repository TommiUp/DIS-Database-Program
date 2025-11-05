INSERT INTO customer VALUES
(1101, 'jussi.virtanen', 'jussi.virtanen@example.com', '+358-40-1111111', 'Mannerheimintie 5, Helsinki', 'FI'),
(1102, 'marie.dubois', 'marie.dubois@example.com', '+33-1-22222222', 'Rue de Rivoli 20, Paris', 'FR'),
(1103, 'carlos.garcia', 'carlos.garcia@example.com', '+34-91-3333333', 'Gran Via 15, Madrid', 'ES'),
(1104, 'giulia.rossi', 'giulia.rossi@example.com', '+39-02-4444444', 'Corso Buenos Aires 10, Milan', 'IT'),
(1105, 'eva.janssen', 'eva.janssen@example.com', '+31-20-5555555', 'Damrak 30, Amsterdam', 'NL');

INSERT INTO seller VALUES
(3101, 'Alpen Outfitters', 'AT', 4.3),
(3102, 'Paris Maison', 'FR', 4.1),
(3103, 'Iberia Digital', 'ES', 4.0),
(3104, 'Milano Moda', 'IT', 4.4),
(3105, 'Benelux Books', 'BE', 4.2);

INSERT INTO product (product_id, seller_id, sku, title, category, price, active) VALUES
(2101, 3101, 'ALP-JACKET', 'Softshell Jacket', 'Apparel', 79.90, TRUE),
(2102, 3102, 'PRS-LAMP', 'Art Deco Lamp', 'Home', 129.00, TRUE),
(2103, 3103, 'IBR-ROUTER', 'Wi-Fi 6 Router', 'Networking', 159.00, TRUE),
(2104, 3104, 'MIL-SHOES', 'Leather Shoes', 'Footwear', 149.50, TRUE),
(2105, 3105, 'BNX-NOVEL', 'Bestseller Novel', 'Books', 18.90, TRUE);

INSERT INTO order_header VALUES
(5101, 1101, '2025-02-01 09:00:00', 'paid', 79.90),
(5102, 1102, '2025-02-02 10:15:00', 'paid', 129.00),
(5103, 1103, '2025-02-03 16:40:00', 'processing', 159.00),
(5104, 1104, '2025-02-04 17:00:00', 'paid', 149.50),
(5105, 1105, '2025-02-05 19:30:00', 'paid', 18.90);

INSERT INTO order_item VALUES
(6101, 5101, 2101, 1, 79.90, 0),
(6102, 5102, 2102, 1, 129.00, 0),
(6103, 5103, 2103, 1, 159.00, 0),
(6104, 5104, 2104, 1, 149.50, 0),
(6105, 5105, 2105, 1, 18.90, 0);