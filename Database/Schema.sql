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
