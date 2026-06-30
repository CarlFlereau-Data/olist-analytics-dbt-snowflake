WITH customers AS (
    SELECT * FROM {{ ref('stg_olist_customers') }}
),
orders AS (
    SELECT * FROM {{ ref('int_orders_enriched') }}
),

customer_orders AS (
    SELECT
    customer_unique_id,
    COUNT(DISTINCT order_id) AS nb_orders,
    SUM(total_paid) AS lifetime_value,
    MIN(ordered_at) AS first_order_at,
    MAX(ordered_at) AS last_order_at,
    AVG(max_review_score) AS avg_review_score
    FROM orders
    GROUP BY 1
),

final AS (
    SELECT
    c.customer_unique_id,
    MAX(c.customer_state) AS customer_state,
    MAX(c.customer_city) AS customer_city,
    co.nb_orders,
    co.lifetime_value,
    co.first_order_at,
    co.last_order_at,
    co.avg_review_score,
    CASE
    WHEN co.nb_orders >= 3 THEN 'loyal'
    WHEN co.nb_orders = 2 THEN 'repeat'
    ELSE 'one time'
    END AS customer_segment

    FROM customers c
    LEFT JOIN customer_orders co ON c.customer_unique_id = co.customer_unique_id
    GROUP BY c.customer_unique_id, co.nb_orders, co.lifetime_value, co.first_order_at, co.last_order_at, co.avg_review_score
)

SELECT * FROM final