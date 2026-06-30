WITH items AS (
    SELECT * FROM {{ ref('stg_olist_order_items') }}
),

products AS (
    SELECT * FROM {{ ref('stg_olist_products') }}
),
sellers AS (
    SELECT * FROM {{ ref('stg_olist_sellers') }}
),
category_translation AS (
    SELECT * FROM {{ ref('product_category_name_translation') }}
),

joined AS (
    SELECT 
    items.order_id,
    items.product_id,
    items.order_item_id,
    items.seller_id,
    items.shipping_limit_at,
    items.item_price,
    items.freight_value,
    items.total_item_value,

    products.category_name_pt,
    COALESCE(category_translation.product_category_name_english, products.category_name_pt) AS category_name,
    products.weight_g,

    sellers.seller_city,
    sellers.seller_state

FROM items
LEFT JOIN products ON items.product_id = products.product_id
LEFT JOIN category_translation ON products.category_name_pt = category_translation.product_category_name
LEFT JOIN sellers ON items.seller_id = sellers.seller_id

)

SELECT * FROM joined