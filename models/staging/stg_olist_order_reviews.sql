WITH source AS (
    SELECT *
    FROM {{ source('olist_raw', 'olist_order_reviews') }}
),

renamed AS (
    SELECT
        {{ clean_id('review_id') }} AS review_id,
        {{ clean_id('order_id') }} AS order_id,
        review_score,
        review_comment_title,
        review_comment_message,
        TRY_TO_TIMESTAMP_NTZ(review_creation_date) AS review_created_at,
        TRY_TO_TIMESTAMP_NTZ(review_answer_timestamp) AS review_answered_at
    FROM source
)

SELECT * FROM renamed