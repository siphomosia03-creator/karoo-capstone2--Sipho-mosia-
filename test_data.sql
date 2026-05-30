INSERT INTO Certifications
(certification_id, supplier_id, certification_name, issue_date, expiry_date)
VALUES
(1, 1, 'Organic Farming Certification', '2025-01-01', '2027-01-01'),
(2, 2, 'Fresh Produce Export Certification', '2025-02-15', '2026-06-10'),
(3, 3, 'Agricultural Quality Assurance', '2024-03-10', '2025-04-01'),
(4, 4, 'Organic Export Certification', '2025-01-15', '2026-12-31'),
(5, 5, 'Agricultural Safety Standard', '2025-02-01', '2026-05-20');

INSERT INTO Harvest_Log
(harvest_id, supplier_id, harvest_date, crop_type, quantity_harvested)
VALUES
(1, 1, '2026-01-01', 'Crop A', 200.00),
(2, 1, '2026-02-01', 'Crop A', 190.00),
(3, 1, '2026-03-01', 'Crop A', 120.00),

(4, 2, '2026-01-01', 'Crop B', 400.00),
(5, 2, '2026-02-01', 'Crop B', 410.00),
(6, 2, '2026-03-01', 'Crop B', 300.00),

(7, 3, '2026-01-15', 'Crop C', 350.00),
(8, 3, '2026-02-15', 'Crop C', 340.00),
(9, 3, '2026-03-15', 'Crop C', 200.00);

INSERT INTO orders
(order_id, supplier_id, order_date, product_name, quantity, total_price)
VALUES
(1, 1, '2026-01-10', 'Product A', 40, 7000.00),
(2, 2, '2026-02-15', 'Product B', 80, 8500.00),
(3, 4, '2026-03-01', 'Product C', 120, 12000.00);