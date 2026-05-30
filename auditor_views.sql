CREATE VIEW v_supplier_health AS
SELECT
    s.supplier_id,
    s.farm_name,
    s.region,
    s.status,
    c.expiry_date,

    CASE
        WHEN c.expiry_date IS NULL THEN 'Unknown'
        WHEN c.expiry_date < DATE('now') THEN 'Expired'
        WHEN c.expiry_date <= DATE('now', '+30 days') THEN 'Expiring Soon'
        ELSE 'Valid'
    END AS cert_status,

    (
        SELECT COUNT(*)
        FROM orders o
        WHERE o.supplier_id = s.supplier_id
        AND o.order_date >= DATE('now', '-90 days')
    ) AS orders_90d,

    (
        SELECT h1.quantity_harvested
        FROM Harvest_Log h1
        WHERE h1.supplier_id = s.supplier_id
        ORDER BY h1.harvest_date DESC
        LIMIT 1
    ) AS latest_yield,

    (
        SELECT AVG(h2.quantity_harvested)
        FROM (
            SELECT quantity_harvested
            FROM Harvest_Log h3
            WHERE h3.supplier_id = s.supplier_id
            ORDER BY h3.harvest_date DESC
            LIMIT 3
        ) h2
    ) AS rolling_avg_yield

FROM suppliers s
LEFT JOIN Certifications c
    ON s.supplier_id = c.supplier_id;

SELECT
    supplier_id,
    farm_name,
    region,
    cert_status,
    orders_90d,
    latest_yield,
    rolling_avg_yield
FROM v_supplier_health
WHERE
    cert_status IN ('Expired', 'Expiring Soon')
    OR orders_90d = 0
    OR latest_yield < (rolling_avg_yield * 0.8);