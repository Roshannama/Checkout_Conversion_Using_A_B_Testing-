CREATE TABLE users
(
    user_id             VARCHAR(20),

    signup_date         DATE,

    country             VARCHAR(50),

    city                VARCHAR(50),

    age                 INTEGER,

    gender              VARCHAR(20),

    customer_type       VARCHAR(20),

    premium_member      BOOLEAN,

    signup_channel      VARCHAR(50),

    lifetime_value      NUMERIC(12,2),

    preferred_device    VARCHAR(20)
);

CREATE TABLE products
(
    product_id          VARCHAR(20),

    product_name        VARCHAR(150),

    category            VARCHAR(50),

    subcategory         VARCHAR(50),

    brand               VARCHAR(100),

    price               NUMERIC(12,2),

    cost                NUMERIC(12,2),

    discount_percent    NUMERIC(5,2),

    rating              NUMERIC(3,1),

    stock_quantity      INTEGER,

    seller              VARCHAR(100),

    launch_date         DATE
);
CREATE TABLE experiment_assignment
(
    assignment_id       VARCHAR(20),

    user_id             VARCHAR(20),

    experiment_name     VARCHAR(100),

    "group"             VARCHAR(20)
);
CREATE TABLE sessions
(
    session_id          VARCHAR(20),

    user_id             VARCHAR(20),

    session_start       TIMESTAMP,

    session_end         TIMESTAMP,

    device              VARCHAR(20),

    browser             VARCHAR(50),

    operating_system    VARCHAR(50),

    traffic_source      VARCHAR(50),

    landing_page        VARCHAR(100),

    country             VARCHAR(50),

    city                VARCHAR(50),

    is_returning        BOOLEAN,

    session_duration    NUMERIC(10,2),

    pages_viewed        INTEGER,

    bounce              BOOLEAN
);
CREATE TABLE events
(
    event_id            VARCHAR(20),

    session_id          VARCHAR(20),

    event_name          VARCHAR(50),

    event_sequence      INTEGER,

    event_time          TIMESTAMP
);

CREATE TABLE orders
(
    order_id            VARCHAR(20),

    user_id             VARCHAR(20),

    session_id          VARCHAR(20),

    product_id          VARCHAR(20),

    quantity             INTEGER,

    unit_price          NUMERIC(12,2),

    discount            NUMERIC(12,2),

    coupon_used         BOOLEAN,

    payment_method      VARCHAR(50),

    shipping_cost       NUMERIC(12,2),

    tax                 NUMERIC(12,2),

    total_amount        NUMERIC(12,2),

    profit              NUMERIC(12,2),

    purchase_time       TIMESTAMP,

    order_status        VARCHAR(30)
);


ALTER TABLE users
ADD CONSTRAINT pk_users
PRIMARY KEY (user_id);


ALTER TABLE products
ADD CONSTRAINT pk_products
PRIMARY KEY (product_id);


ALTER TABLE experiment_assignment
ADD CONSTRAINT pk_experiment_assignment
PRIMARY KEY (assignment_id);


ALTER TABLE sessions
ADD CONSTRAINT pk_sessions
PRIMARY KEY (session_id);


ALTER TABLE events
ADD CONSTRAINT pk_events
PRIMARY KEY (event_id);


ALTER TABLE orders
ADD CONSTRAINT pk_orders
PRIMARY KEY (order_id);

ALTER TABLE experiment_assignment
ADD CONSTRAINT fk_assignment_user
FOREIGN KEY (user_id)
REFERENCES users(user_id);


-- Sessions → Users

ALTER TABLE sessions
ADD CONSTRAINT fk_session_user
FOREIGN KEY (user_id)
REFERENCES users(user_id);


-- Events → Sessions

ALTER TABLE events
ADD CONSTRAINT fk_event_session
FOREIGN KEY (session_id)
REFERENCES sessions(session_id);


-- Orders → Users

ALTER TABLE orders
ADD CONSTRAINT fk_order_user
FOREIGN KEY (user_id)
REFERENCES users(user_id);


-- Orders → Sessions

ALTER TABLE orders
ADD CONSTRAINT fk_order_session
FOREIGN KEY (session_id)
REFERENCES sessions(session_id);


-- Orders → Products

ALTER TABLE orders
ADD CONSTRAINT fk_order_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE experiment_assignment
ADD CONSTRAINT uq_assignment_user
UNIQUE (user_id);


ALTER TABLE users
ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE users
ALTER COLUMN signup_date SET NOT NULL;

ALTER TABLE users
ALTER COLUMN country SET NOT NULL;

ALTER TABLE users
ALTER COLUMN age SET NOT NULL;


ALTER TABLE users
ADD CONSTRAINT chk_user_age
CHECK (age BETWEEN 18 AND 100);


ALTER TABLE users
ADD CONSTRAINT chk_customer_type
CHECK (
    customer_type IN ('New', 'Returning')
);


ALTER TABLE users
ADD CONSTRAINT chk_lifetime_value
CHECK (lifetime_value >= 0);

ALTER TABLE products
ALTER COLUMN product_id SET NOT NULL;

ALTER TABLE products
ALTER COLUMN product_name SET NOT NULL;

ALTER TABLE products
ALTER COLUMN category SET NOT NULL;

ALTER TABLE products
ALTER COLUMN price SET NOT NULL;

ALTER TABLE products
ALTER COLUMN cost SET NOT NULL;


ALTER TABLE products
ADD CONSTRAINT chk_product_price
CHECK (price >= 0);


ALTER TABLE products
ADD CONSTRAINT chk_product_cost
CHECK (cost >= 0);


ALTER TABLE products
ADD CONSTRAINT chk_product_discount
CHECK (
    discount_percent BETWEEN 0 AND 100
);


ALTER TABLE products
ADD CONSTRAINT chk_product_rating
CHECK (
    rating BETWEEN 0 AND 5
);


ALTER TABLE products
ADD CONSTRAINT chk_product_stock
CHECK (
    stock_quantity >= 0
);

ALTER TABLE experiment_assignment
ALTER COLUMN assignment_id SET NOT NULL;

ALTER TABLE experiment_assignment
ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE experiment_assignment
ALTER COLUMN experiment_name SET NOT NULL;


ALTER TABLE experiment_assignment
ADD CONSTRAINT chk_experiment_group
CHECK (
    "group" IN ('Control', 'Treatment')
);

ALTER TABLE sessions
ALTER COLUMN session_id SET NOT NULL;

ALTER TABLE sessions
ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE sessions
ALTER COLUMN session_start SET NOT NULL;

ALTER TABLE sessions
ALTER COLUMN session_end SET NOT NULL;


ALTER TABLE sessions
ADD CONSTRAINT chk_session_time
CHECK (
    session_end >= session_start
);


ALTER TABLE sessions
ADD CONSTRAINT chk_session_duration
CHECK (
    session_duration >= 0
);


ALTER TABLE sessions
ADD CONSTRAINT chk_pages_viewed
CHECK (
    pages_viewed >= 1
);

ALTER TABLE events
ALTER COLUMN event_id SET NOT NULL;

ALTER TABLE events
ALTER COLUMN session_id SET NOT NULL;

ALTER TABLE events
ALTER COLUMN event_name SET NOT NULL;

ALTER TABLE events
ALTER COLUMN event_sequence SET NOT NULL;

ALTER TABLE events
ALTER COLUMN event_time SET NOT NULL;


ALTER TABLE events
ADD CONSTRAINT chk_event_sequence
CHECK (
    event_sequence >= 1
);
ALTER TABLE orders
ALTER COLUMN order_id SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN session_id SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN quantity SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN total_amount SET NOT NULL;


ALTER TABLE orders
ADD CONSTRAINT chk_order_quantity
CHECK (
    quantity > 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_order_unit_price
CHECK (
    unit_price >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_order_discount
CHECK (
    discount >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_shipping_cost
CHECK (
    shipping_cost >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_tax
CHECK (
    tax >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_total_amount
CHECK (
    total_amount >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_profit
CHECK (
    profit >= 0
);


ALTER TABLE orders
ADD CONSTRAINT chk_order_status
CHECK (
    order_status IN
    (
        'Completed',
        'Cancelled',
        'Refunded'
    )
);



CREATE INDEX idx_users_country
ON users(country);

CREATE INDEX idx_users_customer_type
ON users(customer_type);

CREATE INDEX idx_users_premium
ON users(premium_member);

CREATE INDEX idx_users_device
ON users(preferred_device);


/* EXPERIMENT */

CREATE INDEX idx_assignment_group
ON experiment_assignment("group");

CREATE INDEX idx_assignment_experiment
ON experiment_assignment(experiment_name);


/* SESSIONS */

CREATE INDEX idx_sessions_user
ON sessions(user_id);

CREATE INDEX idx_sessions_device
ON sessions(device);

CREATE INDEX idx_sessions_traffic
ON sessions(traffic_source);

CREATE INDEX idx_sessions_start
ON sessions(session_start);


/* EVENTS */

CREATE INDEX idx_events_session
ON events(session_id);

CREATE INDEX idx_events_name
ON events(event_name);

CREATE INDEX idx_events_time
ON events(event_time);


/* ORDERS */

CREATE INDEX idx_orders_user
ON orders(user_id);

CREATE INDEX idx_orders_session
ON orders(session_id);

CREATE INDEX idx_orders_product
ON orders(product_id);

CREATE INDEX idx_orders_purchase_time
ON orders(purchase_time);

CREATE INDEX idx_orders_status
ON orders(order_status);


/* PRODUCTS */

CREATE INDEX idx_products_category
ON products(category);

CREATE INDEX idx_products_brand
ON products(brand);


COPY users
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\users.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

COPY products
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\products.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

COPY experiment_assignment
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\experiment_assignment.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY sessions
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\sessions.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY events
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\events.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);



COPY orders
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\orders.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS chk_profit;

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



/*===========================================================
    07_views.sql
===========================================================*/


CREATE OR REPLACE VIEW vw_experiment_users AS

SELECT
    a.user_id,
    a.experiment_name,
    a."group",

    u.country,
    u.city,
    u.age,
    u.gender,
    u.customer_type,
    u.premium_member,
    u.signup_channel,
    u.preferred_device

FROM experiment_assignment a

JOIN users u
    ON a.user_id = u.user_id;


CREATE OR REPLACE VIEW vw_experiment_sessions AS

SELECT
    s.session_id,
    s.user_id,

    a."group",

    s.session_start,
    s.session_end,
    s.device,
    s.browser,
    s.operating_system,
    s.traffic_source,
    s.landing_page,
    s.is_returning,
    s.session_duration,
    s.pages_viewed,
    s.bounce

FROM sessions s

JOIN experiment_assignment a
    ON s.user_id = a.user_id;

CREATE OR REPLACE VIEW vw_experiment_orders AS

SELECT
    o.order_id,
    o.user_id,
    o.session_id,
    o.product_id,

    a."group",

    o.quantity,
    o.unit_price,
    o.discount,
    o.coupon_used,
    o.payment_method,
    o.shipping_cost,
    o.tax,
    o.total_amount,
    o.profit,
    o.purchase_time,
    o.order_status

FROM orders o

JOIN experiment_assignment a
    ON o.user_id = a.user_id;