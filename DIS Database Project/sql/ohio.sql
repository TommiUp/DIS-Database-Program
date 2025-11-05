INSERT INTO customer VALUES
(1201, 'john.smith', 'john.smith@example.com', '+1-330-1111111', '123 Main St, Akron, OH', 'US'),
(1202, 'emily.davis', 'emily.davis@example.com', '+1-213-2222222', '4th St, Los Angeles, CA', 'US'),
(1203, 'liam.wilson', 'liam.wilson@example.com', '+1-416-3333333', 'King St, Toronto, ON', 'CA'),
(1204, 'sophia.martinez', 'sophia.martinez@example.com', '+52-55-44444444', 'Av. Reforma, Mexico City', 'MX'),
(1205, 'noah.johnson', 'noah.johnson@example.com', '+1-617-5555555', 'Boylston St, Boston, MA', 'US');

INSERT INTO seller VALUES
(3201, 'Midwest Gear', 'US', 4.2),
(3202, 'Pacific Audio', 'US', 4.5),
(3203, 'Maple Crafts', 'CA', 4.1),
(3204, 'Border Foods', 'MX', 4.0),
(3205, 'Yankee Outdoors', 'US', 4.3);

INSERT INTO product (product_id, seller_id, sku, title, category, price, active) VALUES
(2201, 3201, 'MWG-SCREWDR', 'Screwdriver Set', 'Tools', 24.00, TRUE),
(2202, 3202, 'PCA-SPEAKER', 'Bluetooth Speaker', 'Audio', 45.00, TRUE),
(2203, 3203, 'MPC-PLUSH', 'Handmade Plush', 'Toys', 29.50, TRUE),
(2204, 3204, 'BDF-SALSA', 'Chipotle Salsa', 'Grocery', 6.75, TRUE),
(2205, 3205, 'YKO-TENT', '2P Backpacking Tent', 'Outdoors', 179.00, TRUE);

INSERT INTO order_header VALUES
(5201, 1201, '2025-03-01 09:00:00', 'paid', 24.00),
(5202, 1202, '2025-03-02 10:15:00', 'paid', 45.00),
(5203, 1203, '2025-03-03 16:40:00', 'paid', 29.50),
(5204, 1204, '2025-03-04 17:00:00', 'paid', 6.75),
(5205, 1205, '2025-03-05 19:30:00', 'processing', 179.00);

INSERT INTO order_item VALUES
(6201, 5201, 2201, 1, 24.00, 0),
(6202, 5202, 2202, 1, 45.00, 0),
(6203, 5203, 2203, 1, 29.50, 0),
(6204, 5204, 2204, 1, 6.75, 0),
(6205, 5205, 2205, 1, 179.00, 0);