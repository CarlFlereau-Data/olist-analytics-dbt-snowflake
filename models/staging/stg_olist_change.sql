WITH source AS (
    SELECT *
    FROM {{ source('olist_raw', 'olist_change') }}
),

renamed AS (
    SELECT
        TO_DATE(exchange_date, 'DD/MM/YYYY') AS exchange_date,

        TRY_TO_NUMBER(REPLACE(eur_brl_close, ',', '.'), 10, 4) AS eur_brl_close,
        TRY_TO_NUMBER(REPLACE(eur_brl_open, ',', '.'), 10, 4) AS eur_brl_open,
        TRY_TO_NUMBER(REPLACE(eur_brl_high, ',', '.'), 10, 4) AS eur_brl_high,
        TRY_TO_NUMBER(REPLACE(eur_brl_low, ',', '.'), 10, 4) AS eur_brl_low,

        (
            TRY_TO_NUMBER(REPLACE(eur_brl_high, ',', '.'), 10, 4)
            + TRY_TO_NUMBER(REPLACE(eur_brl_low, ',', '.'), 10, 4)
        ) / 2 AS eur_brl_avg_rate,

        NULLIF(volume, '') AS volume

    FROM source
)

SELECT * FROM renamed