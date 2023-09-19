SELECT
    c.company_name AS customer_name,
    SUM(order_totals.order_total) / COUNT(order_totals.order_id) AS avg_order_price
FROM
    Customers c
JOIN (
    SELECT
        o.customer_id,
        o.order_id,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) AS order_total
    FROM
        Orders o
    JOIN
        Order_Details od ON o.order_id = od.order_id
    GROUP BY
        o.customer_id, o.order_id
) AS order_totals ON c.customer_id = order_totals.customer_id
GROUP BY
    c.company_name
ORDER BY
    avg_order_price DESC;


