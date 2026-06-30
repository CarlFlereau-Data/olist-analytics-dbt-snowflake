WITH orders AS (
    SELECT * 
    FROM {{ ref('int_orders_enriched') }}
),

exchange AS (
    SELECT *
    FROM {{ ref('stg_olist_change') }}
),

final AS (
    SELECT
    order_id,
    customer_unique_id,
    order_status,
    payment_type,
    customer_state,
    ordered_at,
    delivered_to_customer_at,
    estimated_delivery_at,
    delivery_days,
    total_paid,
    exchange.eur_brl_avg_rate,
    {{ brl_to_eur('orders.total_paid', 'exchange.eur_brl_avg_rate') }} AS total_paid_eur,
    max_installments,
    delivery_vs_estimated_days,
    max_review_score,

    CASE 
    WHEN delivery_vs_estimated_days < 0 THEN true
    ELSE false
    END AS is_delivered_on_time,
    
    CASE
    WHEN order_status = 'delivered' THEN true
    ELSE false
    END AS is_delivered,

    FROM orders
    LEFT JOIN exchange
        ON exchange.exchange_date <= TO_DATE(orders.ordered_at)
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY orders.order_id
        ORDER BY exchange.exchange_date DESC
    ) = 1
)

SELECT * FROM final