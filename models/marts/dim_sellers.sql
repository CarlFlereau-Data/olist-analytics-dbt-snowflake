WITH sellers AS (
    SELECT * FROM {{ ref('stg_olist_sellers') }}
),
seller_stats AS (
    SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS nb_orders,
    SUM(item_price) AS total_revenue,
    AVG(freight_value) AS avg_freight
    FROM {{ ref('int_order_items_joined') }}
    GROUP BY 1
),

final AS (
    SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    ss.nb_orders,
    ss.total_revenue,
    ss.avg_freight
    FROM sellers s
    LEFT JOIN seller_stats ss ON s.seller_id = ss.seller_id
)

SELECT * FROM final