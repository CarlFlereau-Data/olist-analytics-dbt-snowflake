WITH products AS (
    SELECT * 
    FROM {{ ref('stg_olist_products') }}
),
category_translation AS (
    SELECT * 
    FROM {{ ref('product_category_name_translation') }}
),

item_stats AS (
    SELECT
        product_id,
        COUNT(*) AS nb_times_sold,
        AVG(item_price) AS avg_price,
        SUM(item_price) AS total_revenue
    FROM {{ ref('int_order_items_joined') }}
    GROUP BY 1
),

final AS (
    SELECT
        p.product_id,
        COALESCE(category_translation.product_category_name_english, p.category_name_pt, 'unknown') AS category_name,
        p.category_name_pt,
        p.weight_g,
        p.length_cm,
        p.height_cm,
        p.width_cm,
        s.nb_times_sold,
        s.avg_price,
        s.total_revenue
    FROM products p
    LEFT JOIN category_translation ON p.category_name_pt = category_translation.product_category_name
    LEFT JOIN item_stats s ON p.product_id = s.product_id

)

SELECT * FROM final
