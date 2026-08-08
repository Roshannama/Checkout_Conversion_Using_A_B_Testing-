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