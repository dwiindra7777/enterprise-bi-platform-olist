# Landing Layer — Data Quality Report

## 1. Overview

The Landing Layer contains the raw data ingested from the Brazilian E-Commerce Public Dataset by Olist.

The purpose of this validation is to confirm that the ingested data is structurally consistent and that key relationships between datasets are preserved before downstream transformation.

---

## 2. Row Count Validation

| Table                        | Row Count | Status |
|------------------------------|----------:|--------|
| customers                    | 99,441    | PASS   |
| geolocation                  | 1,000,163 | PASS   |
| order_items                  | 112,650   | PASS   |
| order_payments               | 103,886   | PASS   |
| order_reviews                | 99,224    | PASS   |
| orders                       | 99,441    | PASS   |
| products                     | 32,951    | PASS   |
| sellers                      | 3,095     | PASS   |
| product_category_translation | 71        | PASS   |

**Total rows ingested: 1,550,922**

---

## 3. Critical NULL Validation

Critical identifier columns were checked for NULL values.

**Result: PASS**

All tested critical identifiers contained zero NULL values.

---

## 4. Duplicate Identifier Validation

The following identifiers were checked for duplicate values:

| Column                       | Duplicate Count | Assessment             |
|------------------------------|----------------:|------------------------|
| customers.customer_id        | 0               | PASS                   |
| customers.customer_unique_id | 3,345           | EXPECTED / INVESTIGATE |
| orders.order_id              | 0               | PASS                   |
| products.product_id          | 0               | PASS                   |
| sellers.seller_id            | 0               | PASS                   |

### Finding

`customer_unique_id` contains 3,345 repeated values.

This is not automatically considered a data-quality error because `customer_unique_id` represents a reusable customer identity and may legitimately appear across multiple customer records.

The finding will be considered during downstream data modeling and transformation.

---

## 5. Referential Integrity Validation

The following relationships were tested:

| Relationship            | Orphan Records | Status |
|-------------------------|---------------:|--------|
| orders → customers      | 0              | PASS   |
| order_items → orders    | 0              | PASS   |
| order_items → products  | 0              | PASS   |
| order_items → sellers   | 0              | PASS   |
| order_payments → orders | 0              | PASS   |
| order_reviews → orders  | 0              | PASS   |

**Result: PASS**

No orphan records were detected in the tested relationships.

---

## 6. Validation Conclusion

The Landing Layer successfully ingested all nine source CSV files.

The validation checks confirmed:

- Row counts are consistent with the ingestion results.
- No NULL values were detected in the tested critical identifiers.
- Primary identifier candidates showed no duplicates.
- No orphan records were detected in the tested relationships.
- Repeated `customer_unique_id` values were identified and documented as a data-modeling consideration.

No data cleansing or transformation was performed in the Landing Layer.

The data is therefore ready to proceed to the downstream Staging Layer.