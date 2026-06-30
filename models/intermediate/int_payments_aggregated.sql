WITH payments AS (
SELECT * FROM {{ ref('stg_olist_order_payments') }}
),

aggregated AS (
    SELECT
    order_id,
    SUM(payment_value) AS total_paid,
    COUNT(*) AS nb_payment_lines,
    MAX(nb_installments) AS max_installments,
    MAX(payment_type) AS payment_type_sample
    FROM payments
    GROUP BY 1

)

SELECT * FROM aggregated