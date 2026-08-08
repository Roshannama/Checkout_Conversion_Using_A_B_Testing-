SELECT 'users' AS table_name, COUNT(*) AS row_count
FROM users

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'experiment_assignment', COUNT(*)
FROM experiment_assignment

UNION ALL

SELECT 'sessions', COUNT(*)
FROM sessions

UNION ALL

SELECT 'events', COUNT(*)
FROM events

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders;

SELECT
    user_id,
    COUNT(*) AS occurrences
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;


/*===========================================================
    3. DUPLICATE PRODUCTS
===========================================================*/

SELECT
    product_id,
    COUNT(*) AS occurrences
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


/*===========================================================
    4. DUPLICATE SESSIONS
===========================================================*/

SELECT
    session_id,
    COUNT(*) AS occurrences
FROM sessions
GROUP BY session_id
HAVING COUNT(*) > 1;


/*===========================================================
    5. USERS WITHOUT ASSIGNMENT
===========================================================*/

SELECT COUNT(*) AS users_without_assignment
FROM users u
LEFT JOIN experiment_assignment a
    ON u.user_id = a.user_id
WHERE a.user_id IS NULL;


/*===========================================================
    6. SESSIONS WITHOUT USERS
===========================================================*/

SELECT COUNT(*) AS orphan_sessions
FROM sessions s
LEFT JOIN users u
    ON s.user_id = u.user_id
WHERE u.user_id IS NULL;


/*===========================================================
    7. EVENTS WITHOUT SESSIONS
===========================================================*/

SELECT COUNT(*) AS orphan_events
FROM events e
LEFT JOIN sessions s
    ON e.session_id = s.session_id
WHERE s.session_id IS NULL;


/*===========================================================
    8. ORDERS WITHOUT USERS
===========================================================*/

SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN users u
    ON o.user_id = u.user_id
WHERE u.user_id IS NULL;


/*===========================================================
    9. ORDERS WITHOUT PRODUCTS
===========================================================*/

SELECT COUNT(*) AS invalid_product_orders
FROM orders o
LEFT JOIN products p
    ON o.product_id = p.product_id
WHERE p.product_id IS NULL;


/*===========================================================
    10. ORDERS WITHOUT SESSIONS
===========================================================*/

SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN sessions s
    ON o.session_id = s.session_id
WHERE s.session_id IS NULL;


/*===========================================================
    11. INVALID SESSION TIMES
===========================================================*/

SELECT COUNT(*) AS invalid_sessions
FROM sessions
WHERE session_end < session_start;


/*===========================================================
    12. NEGATIVE FINANCIAL VALUES
===========================================================*/

SELECT COUNT(*) AS invalid_orders
FROM orders
WHERE total_amount < 0
   OR profit < 0
   OR discount < 0
   OR shipping_cost < 0
   OR tax < 0;


/*===========================================================
    13. INVALID PRODUCT VALUES
===========================================================*/

SELECT COUNT(*) AS invalid_products
FROM products
WHERE price < 0
   OR cost < 0
   OR discount_percent < 0
   OR discount_percent > 100
   OR rating < 0
   OR rating > 5
   OR stock_quantity < 0;


/*===========================================================
    14. EXPERIMENT BALANCE
===========================================================*/

SELECT
    "group",
    COUNT(*) AS users,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM experiment_assignment
GROUP BY "group";


/*===========================================================
    15. MISSING VALUES
===========================================================*/

SELECT
    COUNT(*) FILTER (WHERE user_id IS NULL)
        AS missing_user_id,

    COUNT(*) FILTER (WHERE country IS NULL)
        AS missing_country,

    COUNT(*) FILTER (WHERE age IS NULL)
        AS missing_age,

    COUNT(*) FILTER (WHERE premium_member IS NULL)
        AS missing_premium_status
FROM users;


/*===========================================================
    16. EVENT DISTRIBUTION
===========================================================*/

SELECT
    event_name,
    COUNT(*) AS event_count
FROM events
GROUP BY event_name
ORDER BY event_count DESC;


/*===========================================================
    17. ORDER STATUS
===========================================================*/

SELECT
    order_status,
    COUNT(*) AS orders,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY order_status
ORDER BY orders DESC;
