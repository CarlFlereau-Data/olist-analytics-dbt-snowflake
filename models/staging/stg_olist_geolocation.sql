WITH source AS (
    SELECT * 
    FROM {{source('olist_raw', 'olist_geolocation')}}
),
dedup AS (
    SELECT
    geolocation_zip_code_prefix AS zip_code_prefix,
    AVG(geolocation_lat) AS latitude,
    AVG(geolocation_lng) AS longitude,
    MAX(initcap(geolocation_city)) AS city,
    MAX(upper(geolocation_state)) AS state
    FROM source
    GROUP BY 1
)

SELECT * FROM dedup