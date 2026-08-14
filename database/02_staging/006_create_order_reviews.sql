/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.order_reviews
Purpose : Transform and standardize order review source data
*/

DROP TABLE IF EXISTS staging.order_reviews;

CREATE TABLE staging.order_reviews AS
SELECT
    TRIM(review_id)::TEXT AS review_id,
    TRIM(order_id)::TEXT AS order_id,
    review_score::INTEGER AS review_score,
    NULLIF(TRIM(review_comment_title), '')::TEXT AS review_comment_title,
    NULLIF(TRIM(review_comment_message), '')::TEXT AS review_comment_message,
    review_creation_date::TIMESTAMP AS review_creation_date,
    review_answer_timestamp::TIMESTAMP AS review_answer_timestamp
FROM landing.order_reviews;