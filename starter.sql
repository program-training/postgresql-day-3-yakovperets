
-- 1
-- מציאת מספר ההזמנות לכל עובד.נמזג מיזוג שמאלי.נכווץ על פי עובד את כמות ההזמנות.נסדר לפי איי די.
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(o.order_id) AS order_count
FROM
    Employees e
LEFT JOIN
    Orders o ON e.employee_id = o.employee_id
GROUP BY
    e.employee_id, e.first_name, e.last_name
ORDER BY
    e.employee_id;
-- 2
-- נמזג את טבלת הקטגוריות עם טבלת המוצרים נמזג גם את טבלת ההזמנות עם טבלת המוצרים, נחשב את כמות ההזמנות כפול כמות המוצר עבור מוצר יחיד. נכווץ את מחירי המוצרים על פי קטגוריה
SELECT
    c.category_name,
    SUM(od.quantity * od.unit_price*(1-od.discount)) AS total_sales_amount
FROM
    Categories c
JOIN
    Products p ON c.category_id = p.category_id
JOIN
    Order_Details od ON p.product_id = od.product_id
GROUP BY
    c.category_name
ORDER BY
    total_sales_amount DESC;

-- 3
-- עשיתי כמו ההבנה של שאר הכיתה אתקן כשאגיע לתת שאילתות
SELECT
   c.company_name AS customer_name,
    AVG(od.quantity * od.unit_price) AS avg_sales_amount
FROM
    customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
JOIN
    Order_Details od ON o.order_id = od.order_id
GROUP BY
    c.company_name
ORDER BY
    avg_sales_amount DESC;
-- 4
SELECT
   c.company_name AS customer_name,
    SUM(od.quantity * od.unit_price) AS avg_sales_amount
FROM
    customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
JOIN
    Order_Details od ON o.order_id = od.order_id
GROUP BY
    c.company_name
ORDER BY
    avg_sales_amount DESC;
	LIMIT 10
-- 5
SELECT
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(od.quantity * od.unit_price) AS total_sales_amount
FROM
    Orders o
JOIN
    Order_Details od ON o.order_id = od.order_id
GROUP BY
    EXTRACT(MONTH FROM o.order_date)
ORDER BY
    EXTRACT(MONTH FROM o.order_date);

-- 6
SELECT
    product_name,
    units_in_stock
FROM
    Products
WHERE
    units_in_stock < 10;
-- 7
SELECT
    o.order_id,
    c.company_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_price
FROM
    Orders o
JOIN
    Customers c ON o.customer_id = c.customer_id
JOIN
    Order_Details od ON o.order_id = od.order_id
JOIN
    Products p ON od.product_id = p.product_id
GROUP BY
    o.order_id, c.company_name
ORDER BY
    SUM(od.quantity * od.unit_price * (1 - od.discount)) DESC
	LIMIT 1;
-- 8
SELECT
    o.ship_country AS country,
    SUM(od.quantity * od.unit_price*(1-od.discount)) AS total_revenue
FROM
    Orders o
JOIN
    Order_Details od ON o.order_id = od.order_id
GROUP BY
    o.ship_country
ORDER BY
    total_revenue DESC;

-- 9
SELECT
    s.company_name,
    COUNT(o.ship_via) AS order_count
FROM
    Shippers s
JOIN
    Orders o ON s.shipper_id = o.ship_via
GROUP BY
    s.company_name
ORDER BY
    order_count DESC
LIMIT 1;

-- 10
-- ננצל את האיחוד השמאלי על פי מוצר כך שבמקום שאין הזמנה יהיה נאל כך שנוכל לדעת מי לא נמכר
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

