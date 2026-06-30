WITH source AS (
    SELECT * FROM {{ source('olist_raw', 'olist_customers') }}

),

renamed AS (
    SELECT
    {{ clean_id('customer_id') }} AS customer_id,
    {{ clean_id('customer_unique_id') }} AS customer_unique_id,
    customer_zip_code_prefix AS zip_code_prefix,
    initcap(customer_city) AS customer_city,
    UPPER(customer_state) AS customer_state

    FROM source

)

SELECT * FROM renamed