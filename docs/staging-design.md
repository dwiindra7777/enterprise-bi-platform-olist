# Staging Layer Design

## 1. Purpose

The Staging Layer serves as the intermediate transformation layer between the raw Landing Layer and the downstream Data Warehouse.

Its primary purpose is to standardize, clean, validate, and prepare source data for dimensional modeling while preserving the original source data in the Landing Layer.

## 2. Staging Layer Responsibilities

The Staging Layer is responsible for:

- Standardizing source data types.
- Standardizing column naming conventions.
- Handling and documenting NULL values where appropriate.
- Applying source-level data cleansing rules.
- Normalizing text and categorical values where required.
- Standardizing date and timestamp representations.
- Preparing source data for downstream dimensional modeling.
- Applying reproducible SQL-based transformations.
- Supporting data-quality validation before data enters the Data Warehouse.

The Staging Layer must not modify the raw Landing Layer.

## 3. Landing-to-Staging Architecture

The data flow follows a layered architecture:

Source CSV Files
        ↓
Landing Layer
        ↓
Staging Layer
        ↓
Data Warehouse
        ↓
Semantic Model
        ↓
Power BI

The Landing Layer preserves source data in its ingested form.

The Staging Layer transforms and standardizes the data for downstream consumption.

The Data Warehouse will later apply dimensional modeling and business-oriented structures.

## 4. Transformation Principles

The Staging Layer follows the following principles:

1. Preserve the Landing Layer as the raw source of record.
2. Perform transformations using reproducible SQL scripts.
3. Avoid destructive modifications to Landing data.
4. Prefer deterministic and idempotent transformations.
5. Apply explicit data type conversions rather than relying on implicit casting.
6. Document transformation rules that affect business interpretation.
7. Separate data cleansing from downstream business logic where practical.
8. Validate transformed data before loading it into the Data Warehouse.
9. Maintain traceability between Landing source columns and Staging columns.
10. Design transformations to support future incremental processing.

## 5. Source-to-Staging Mapping

### 5.1 Mapping Overview

| Landing Table                             | Staging Table                             | Transformation Purpose                                                      |
| ----------------------------------------- | ----------------------------------------- | --------------------------------------------------------------------------- |
| landing.customers                         | staging.customers                         | Standardize customer attributes and data types                              |
| landing.geolocation                       | staging.geolocation                       | Standardize geographic attributes and numeric coordinates                   |
| landing.order_items                       | staging.order_items                       | Standardize item-level transaction attributes and numeric fields            |
| landing.order_payments                    | staging.order_payments                    | Standardize payment attributes and numeric fields                           |
| landing.order_reviews                     | staging.order_reviews                     | Standardize review attributes and review timestamps                         |
| landing.orders                            | staging.orders                            | Standardize order attributes, timestamps, and status values                 |
| landing.products                          | staging.products                          | Standardize product attributes, numeric dimensions, and category references |
| landing.sellers                           | staging.sellers                           | Standardize seller attributes and geographic references                     |
| landing.product_category_name_translation | staging.product_category_name_translation | Standardize category names and translation attributes                       |

### 5.2 Transformation Rules by Table

#### customers

| Source Column            | Staging Column           | Transformation                           |
| ------------------------ | ------------------------ | ---------------------------------------- |
| customer_id              | customer_id              | Preserve identifier; standardize as text |
| customer_unique_id       | customer_unique_id       | Preserve identifier; standardize as text |
| customer_zip_code_prefix | customer_zip_code_prefix | Standardize as text                      |
| customer_city            | customer_city            | Normalize text representation            |
| customer_state           | customer_state           | Normalize state code representation      |

#### geolocation

| Source Column               | Staging Column              | Transformation                      |
| --------------------------- | --------------------------- | ----------------------------------- |
| geolocation_zip_code_prefix | geolocation_zip_code_prefix | Standardize as text                 |
| geolocation_lat             | geolocation_lat             | Standardize as numeric              |
| geolocation_lng             | geolocation_lng             | Standardize as numeric              |
| geolocation_city            | geolocation_city            | Normalize text representation       |
| geolocation_state           | geolocation_state           | Normalize state code representation |

#### order_items

| Source Column       | Staging Column      | Transformation                           |
| ------------------- | ------------------- | ---------------------------------------- |
| order_id            | order_id            | Preserve identifier; standardize as text |
| order_item_id       | order_item_id       | Standardize as integer                   |
| product_id          | product_id          | Preserve identifier; standardize as text |
| seller_id           | seller_id           | Preserve identifier; standardize as text |
| shipping_limit_date | shipping_limit_date | Standardize as timestamp                 |
| price               | price               | Standardize as numeric                   |
| freight_value       | freight_value       | Standardize as numeric                   |

#### order_payments

| Source Column        | Staging Column       | Transformation                           |
| -------------------- | -------------------- | ---------------------------------------- |
| order_id             | order_id             | Preserve identifier; standardize as text |
| payment_sequential   | payment_sequential   | Standardize as integer                   |
| payment_type         | payment_type         | Normalize categorical text               |
| payment_installments | payment_installments | Standardize as integer                   |
| payment_value        | payment_value        | Standardize as numeric                   |

#### order_reviews

| Source Column           | Staging Column          | Transformation                           |
| ----------------------- | ----------------------- | ---------------------------------------- |
| review_id               | review_id               | Preserve identifier; standardize as text |
| order_id                | order_id                | Preserve identifier; standardize as text |
| review_score            | review_score            | Standardize as integer                   |
| review_comment_title    | review_comment_title    | Normalize text and preserve NULL         |
| review_comment_message  | review_comment_message  | Normalize text and preserve NULL         |
| review_creation_date    | review_creation_date    | Standardize as timestamp                 |
| review_answer_timestamp | review_answer_timestamp | Standardize as timestamp                 |

#### orders

| Source Column                 | Staging Column                | Transformation                           |
| ----------------------------- | ----------------------------- | ---------------------------------------- |
| order_id                      | order_id                      | Preserve identifier; standardize as text |
| customer_id                   | customer_id                   | Preserve identifier; standardize as text |
| order_status                  | order_status                  | Normalize categorical text               |
| order_purchase_timestamp      | order_purchase_timestamp      | Standardize as timestamp                 |
| order_approved_at             | order_approved_at             | Standardize as timestamp; preserve NULL  |
| order_delivered_carrier_date  | order_delivered_carrier_date  | Standardize as timestamp; preserve NULL  |
| order_delivered_customer_date | order_delivered_customer_date | Standardize as timestamp; preserve NULL  |
| order_estimated_delivery_date | order_estimated_delivery_date | Standardize as timestamp                 |

#### products

| Source Column              | Staging Column             | Transformation                           |
| -------------------------- | -------------------------- | ---------------------------------------- |
| product_id                 | product_id                 | Preserve identifier; standardize as text |
| product_category_name      | product_category_name      | Normalize category text; preserve NULL   |
| product_name_lenght        | product_name_lenght        | Standardize as integer; preserve NULL    |
| product_description_lenght | product_description_lenght | Standardize as integer; preserve NULL    |
| product_photos_qty         | product_photos_qty         | Standardize as integer; preserve NULL    |
| product_weight_g           | product_weight_g           | Standardize as integer; preserve NULL    |
| product_length_cm          | product_length_cm          | Standardize as integer; preserve NULL    |
| product_height_cm          | product_height_cm          | Standardize as integer; preserve NULL    |
| product_width_cm           | product_width_cm           | Standardize as integer; preserve NULL    |

#### sellers

| Source Column          | Staging Column         | Transformation                           |
| ---------------------- | ---------------------- | ---------------------------------------- |
| seller_id              | seller_id              | Preserve identifier; standardize as text |
| seller_zip_code_prefix | seller_zip_code_prefix | Standardize as text                      |
| seller_city            | seller_city            | Normalize text representation            |
| seller_state           | seller_state           | Normalize state code representation      |

#### product_category_name_translation

| Source Column                 | Staging Column                | Transformation          |
| ----------------------------- | ----------------------------- | ----------------------- |
| product_category_name         | product_category_name         | Normalize category text |
| product_category_name_english | product_category_name_english | Normalize category text |

## 6. Data Type Standardization

The Staging Layer will use explicit PostgreSQL data types to ensure consistent representation of source data.

| Data Category               | PostgreSQL Data Type     | Standardization Rule                                                        |
| --------------------------- | ------------------------ | --------------------------------------------------------------------------- |
| Business identifiers        | `TEXT`                   | Preserve source identifiers as text                                         |
| Postal code prefixes        | `TEXT`                   | Preserve leading zeros and avoid numeric interpretation                     |
| Integer quantities          | `INTEGER`                | Use for count-based and sequential numeric attributes                       |
| Monetary values             | `NUMERIC(18,2)`          | Use for prices, freight values, payment values, and other monetary measures |
| Geographic coordinates      | `NUMERIC(10,7)`          | Use for latitude and longitude values                                       |
| Dates and timestamps        | `TIMESTAMP`              | Standardize source date/time fields                                         |
| Categorical attributes      | `TEXT`                   | Normalize and preserve categorical values                                   |
| Free-text attributes        | `TEXT`                   | Preserve source text while applying appropriate normalization               |
| Nullable numeric attributes | Appropriate numeric type | Preserve NULL when the source value is missing                              |

## 7. Data Quality Rules

The Staging Layer will apply data-quality checks to ensure that transformed data is structurally valid and suitable for downstream processing.

### 7.1 Completeness

Critical business identifiers must not be NULL.

Examples include:

- `order_id`
- `customer_id`
- `customer_unique_id`
- `product_id`
- `seller_id`
- `review_id`

Nullable attributes may remain NULL when the source system does not provide a value.

### 7.2 Uniqueness

Primary business identifiers must maintain their expected uniqueness within the applicable table.

For transactional tables, uniqueness rules must consider the table grain.

For example:

- `orders.order_id` should be unique.
- `customers.customer_id` should be unique.
- `products.product_id` should be unique.
- `sellers.seller_id` should be unique.
- `order_items` should be unique at the `(order_id, order_item_id)` grain.

### 7.3 Referential Integrity

Relationships between related entities must be validated.

Examples include:

- Orders must reference existing customers.
- Order items must reference existing orders.
- Order items must reference existing products.
- Order items must reference existing sellers.
- Payments must reference existing orders.
- Reviews must reference existing orders.

### 7.4 Domain Validation

Business attributes should be validated against reasonable domain constraints.

Examples include:

- `review_score` should fall within the expected review-score range.
- Monetary values should not contain invalid negative values unless explicitly supported by the source business rules.
- Geographic coordinates should fall within valid latitude and longitude ranges.
- Sequential or quantity fields should not contain invalid negative values where negative values are not meaningful.

### 7.5 Temporal Validation

Date and timestamp fields should be checked for logical consistency where applicable.

Examples include:

- Approval timestamps should not precede purchase timestamps when both are available.
- Delivery timestamps should not precede purchase timestamps.
- Review timestamps should be evaluated against the associated order lifecycle where appropriate.

### 7.6 Transformation Validation

Transformation processes must compare relevant Landing and Staging metrics.

Validation should include:

- Row counts.
- NULL counts.
- Duplicate counts.
- Referential integrity.
- Domain-rule violations.
- Transformation exceptions.

Quality checks should be reproducible through SQL rather than relying exclusively on manual inspection.

## 8. Transformation Strategy

The Staging Layer will use SQL-based transformations executed against the Landing Layer.

### 8.1 Transformation Approach

Transformations will follow a deterministic and reproducible process:

Landing
    ↓
Extract source columns
    ↓
Explicit data type conversion
    ↓
Data cleansing and normalization
    ↓
Business-rule validation
    ↓
Staging table

### 8.2 Type Conversion

Source fields will be explicitly cast to the standardized PostgreSQL data types defined in Section 6.

Implicit type conversion should be avoided where practical.

### 8.3 Text Standardization

Text attributes may be standardized through:

- Trimming unnecessary whitespace.
- Normalizing categorical representations where appropriate.
- Preserving meaningful source values.
- Preserving NULL values when NULL represents missing source information.

Transformations must avoid changing business meaning merely for cosmetic consistency.

### 8.4 Date and Timestamp Standardization

Source date and timestamp fields will be explicitly converted into PostgreSQL `TIMESTAMP` values.

NULL source timestamps will remain NULL unless a documented business rule requires another treatment.

### 8.5 Numeric Standardization

Numeric attributes will be explicitly cast into the appropriate PostgreSQL numeric types.

Monetary values will use `NUMERIC(18,2)`.

Geographic coordinates will use an appropriate fixed-precision numeric representation.

### 8.6 Transformation Idempotency

Staging transformations should be designed so that repeated execution produces the same result for the same Landing input.

Transformations must not depend on the previous contents of the Staging Layer.

### 8.7 Source Preservation

The Landing Layer remains immutable from the perspective of the Staging transformation process.

Staging transformations must read from Landing and write to Staging without modifying or deleting Landing records.

### 8.8 Incremental Processing Readiness

The transformation design should preserve the ability to introduce incremental processing in later stages of the project.

Where appropriate, source timestamps and business keys should remain available in Staging to support future incremental extraction and loading strategies.

### 8.9 Error Handling

Transformation anomalies should be detectable through validation queries and documented quality checks.

Records should not be silently discarded unless an explicit business or technical rule requires exclusion.

Any exclusion or filtering rule must be documented.

## 9. Naming Conventions

The Staging Layer will follow consistent naming conventions:

1. Schema names use lowercase snake_case.
2. Table names use lowercase snake_case.
3. Column names use lowercase snake_case.
4. Business identifiers retain descriptive names such as `order_id`, `customer_id`, and `product_id`.
5. PostgreSQL reserved keywords must not be used as column names where avoidable.
6. Staging table names should remain aligned with their corresponding Landing source tables unless a transformation requires a different name.
7. Naming changes between Landing and downstream layers must be explicitly documented to preserve data lineage.
8. Acronyms should be avoided unless they are established domain conventions.
9. Column names should describe the business meaning of the attribute rather than its physical storage implementation.

## 10. Data Lineage

The Staging Layer maintains traceability between source data in the Landing Layer and transformed data in the Staging Layer.

The lineage pattern is:

Source CSV
    ↓
Landing Table
    ↓
Staging Transformation
    ↓
Staging Table
    ↓
Data Warehouse

### 10.1 Source-to-Staging Lineage

| Source                         | Landing Table                             | Staging Table                             | Transformation Scope                                             |
| ------------------------------ | ----------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------- |
| Olist Customers CSV            | landing.customers                         | staging.customers                         | Type standardization, text normalization, validation             |
| Olist Geolocation CSV          | landing.geolocation                       | staging.geolocation                       | Type standardization, geographic validation                      |
| Olist Order Items CSV          | landing.order_items                       | staging.order_items                       | Type standardization, numeric standardization, validation        |
| Olist Order Payments CSV       | landing.order_payments                    | staging.order_payments                    | Type standardization, categorical normalization, validation      |
| Olist Order Reviews CSV        | landing.order_reviews                     | staging.order_reviews                     | Type standardization, text normalization, timestamp validation   |
| Olist Orders CSV               | landing.orders                            | staging.orders                            | Type standardization, status normalization, timestamp validation |
| Olist Products CSV             | landing.products                          | staging.products                          | Type standardization, category normalization, numeric validation |
| Olist Sellers CSV              | landing.sellers                           | staging.sellers                           | Type standardization, text normalization, geographic validation  |
| Olist Category Translation CSV | landing.product_category_name_translation | staging.product_category_name_translation | Text normalization and validation                                |

### 10.2 Lineage Principles

1. Every Staging table must have an identifiable Landing source.
2. Source columns should remain traceable to their corresponding Staging columns.
3. Transformation rules must be documented when source values are modified.
4. Landing data remains the raw source of record.
5. Staging transformations must be reproducible from the documented source and transformation logic.
6. Downstream Data Warehouse transformations must be distinguishable from Staging-level cleansing and standardization.