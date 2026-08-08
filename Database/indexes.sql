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
