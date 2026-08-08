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
