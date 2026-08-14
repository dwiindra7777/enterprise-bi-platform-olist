/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.geolocation
Purpose : Transform and standardize geographic source data
*/

DROP TABLE IF EXISTS staging.geolocation;

CREATE TABLE staging.geolocation AS
SELECT
    TRIM(geolocation_zip_code_prefix)::TEXT AS geolocation_zip_code_prefix,
    geolocation_lat::NUMERIC(10,7) AS geolocation_lat,
    geolocation_lng::NUMERIC(10,7) AS geolocation_lng,
    TRIM(geolocation_city)::TEXT AS geolocation_city,
    UPPER(TRIM(geolocation_state))::TEXT AS geolocation_state
FROM landing.geolocation;