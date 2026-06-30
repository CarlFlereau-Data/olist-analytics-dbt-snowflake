WITH source AS (
    SELECT *
    FROM {{ source('olist_raw', 'olist_products') }}
),

renamed AS (
    SELECT
        {{ clean_id('product_id') }} AS product_id,
        product_category_name AS category_name_pt,
        product_photos_qty AS nb_photos,
        product_weight_g AS weight_g,
        product_length_cm AS length_cm,
        product_height_cm AS height_cm,
        product_width_cm AS width_cm
    FROM source
)

SELECT * FROM renamed