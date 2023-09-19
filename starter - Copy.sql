-- 1
SELECT
    c.company_name,
    o.order_id
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
WHERE
    o.customer_id IS  NULL;
-- 2
SELECT
    c.company_name,
    COUNT(o.order_id) AS num_of_orders
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
	GROUP BY c.company_name
HAVING  COUNT(o.order_id) >10
ORDER BY num_of_orders DESC
-- 3
SELECT
    product_id,
    product_name,
    unit_price
FROM
    Products
WHERE
    unit_price > (SELECT AVG(unit_price) FROM Products)
ORDER BY unit_price DESC;
-- 4
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.units_in_stock,
    p.unit_price
FROM
    Products p
LEFT JOIN
    Order_Details od ON p.product_id = od.product_id
WHERE
    od.product_id IS  NULL;
-- 5
SELECT
    country,
    COUNT(*) AS customer_count
FROM
    Customers
GROUP BY
    country
HAVING count(*)>5
ORDER BY
    customer_count DESC;
-- 6
SELECT
    c.company_name,
    o.order_id,
    o.order_date
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id AND EXTRACT(YEAR FROM o.order_date) = 1998
WHERE
    (o.order_id IS  NULL );
-- 7
SELECT
    c.company_name,
    o.order_id,
    o.order_date
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id AND o.order_date >= '1999-01-01' 
WHERE
    c.country = 'Germany'
    AND o.order_id IS NULL;
-- 8
SELECT
    c.company_name,
    COUNT(o.order_id) AS num_of_orders
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
	GROUP BY c.company_name
HAVING  COUNT(o.order_id) =3
ORDER BY c.company_name DESC;
-- 9
-- אין כזה שדה
-- 10
SELECT
    s.country,
    s.company_name,
    COUNT(p.product_id) AS num_of_products
FROM
    Suppliers s
LEFT JOIN
    Products p ON s.supplier_id = p.supplier_id
GROUP BY
    s.country, s.company_name
HAVING
    COUNT(p.product_id) > 1 AND s.country = 'USA'
ORDER BY
    num_of_products DESC;