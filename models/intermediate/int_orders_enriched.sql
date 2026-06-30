WITH orders AS (
    SELECT * FROM {{ ref('stg_olist_orders') }}
),
customers AS (
    SELECT * FROM {{ ref('stg_olist_customers') }}
),
payments AS (
    SELECT * FROM {{ ref('int_payments_aggregated') }}
),
reviews AS (
    SELECT
    order_id,
    MAX(review_score) AS max_review_score
    FROM {{ ref('stg_olist_order_reviews') }}
    GROUP BY order_id
),

enriched AS (
    SELECT
    orders.order_id,
    orders.customer_id,

    customers.customer_unique_id,
    customers.customer_city,
    customers.customer_state,

    orders.order_status,
    orders.ordered_at,
    orders.approved_at,
    orders.delivered_to_customer_at,
    orders.estimated_delivery_at,

    datediff('day', orders.ordered_at, orders.delivered_to_customer_at) AS delivery_days,
    datediff('day', orders.estimated_delivery_at, orders.delivered_to_customer_at) AS delivery_vs_estimated_days,

    payments.total_paid,
    payments.max_installments,
    payments.payment_type_sample AS payment_type,

    reviews.max_review_score

    FROM orders
    LEFT JOIN customers ON orders.customer_id = customers.customer_id
    LEFT JOIN payments ON orders.order_id = payments.order_id
    LEFT JOIN reviews ON orders.order_id = reviews.order_id
)

SELECT * FROM enriched