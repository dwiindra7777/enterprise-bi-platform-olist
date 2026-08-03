# Business Requirement Document

## Document Information

| Item           | Value                                                 |
|----------------|-------------------------------------------------------|
| Document Title | Business Requirement Document                         |
| Project Name   | Enterprise Marketplace Business Intelligence Platform |
| Dataset        | Brazilian E-Commerce Public Dataset by Olist          |
| Version        | 1.0                                                   |
| Author         | Dwi Indra                                             |
| Language       | English (US)                                          |
| Repository     | enterprise-bi-platform-olist                          |
| Created Date   | 2026-08-03                                            |

## Business Background

The organization operates a large-scale e-commerce marketplace where customers purchase products from multiple sellers across different regions. Daily business operations generate transactional data covering orders, payments, deliveries, customer reviews, products, sellers, and customer information. 

Although operational data is available, it is distributed across multiple source files and is not organized for analytical reporting. Business users must manually consolidate data from different sources to monitor sales performance, customer behavior, logistics performance, seller performance, and overall business health.

To support data-driven decision making, the organization requires an integrated Business Intelligence platform capable of transforming raw operational data into reliable, standardized, and easily accessible business insights.

## Problem Statement

The current reporting process presents several business challenges:
- Business data is fragmented across multiple operational datasets.
- Reporting requires manual data preparation before analysis.
- KPI calculations are not standardized across reports.
- Decision makers lack a centralized and trusted source of business information.
- Operational performance cannot be monitored efficiently in near real-time.
- Business users spend excessive time preparing reports instead of analyzing business performance.

These challenges increase reporting effort, reduce data consistency, and slow down strategic decision making.

## Business Objectives

The primary objectives of this Business Intelligence platform are:
1. Centralize operational data from multiple business domains into a single analytical platform.
2. Standardize business KPIs to ensure consistent reporting across departments.
3. Reduce manual reporting effort through automated ETL processes.
4. Enable interactive and self-service business analysis using Power BI.
5. Improve decision-making by providing timely, accurate, and reliable business insights.
6. Establish a scalable data foundation that supports future analytical requirements.

## Stakeholders

| Stakeholder          | Responsibility                       | Primary Needs                                              |
|----------------------|--------------------------------------|------------------------------------------------------------|
| Executive Management | Monitor overall business performance | Executive KPIs and strategic insights                      |
| Sales Team           | Monitor sales performance            | Revenue, orders, sales trends                              |
| Operations Team      | Monitor fulfillment and logistics    | Delivery performance and operational efficiency            |
| Seller Management    | Evaluate seller performance          | Seller rankings, fulfillment quality, sales contribution   |
| Business Analysts    | Perform ad-hoc analysis              | Interactive dashboards and detailed filtering capabilities |

## Project Scope

This project includes the following components:
- Import raw CSV datasets into PostgreSQL.
- Design Landing, Staging, and Data Warehouse layers.
- Build ETL processes using SQL and Power Query.
- Perform automated data validation checks.
- Design a Star Schema for analytical reporting.
- Develop a semantic model in Power BI.
- Build interactive dashboards for business users.
- Implement Row-Level Security (RLS) to simulate access control.
- Simulate publishing and refresh processes.
- Produce technical documentation and business recommendations.

## Out of Scope

The following items are intentionally excluded from this project:
- Real-time data streaming.
- Cloud infrastructure deployment (Azure, AWS, GCP).
- Machine Learning or predictive analytics.
- Customer-facing applications.
- Production-grade workflow orchestration tools (e.g., Apache Airflow).
- CI/CD pipelines.
- Multi-source system integration beyond the provided dataset.

## Business Requirements

The Business Intelligence platform shall:
- Consolidate operational data into a centralized analytical repository.
- Provide standardized business KPIs across all reports.
- Enable interactive reporting for business users.
- Reduce manual reporting effort through automated data transformation.
- Improve data visibility across sales, customers, products, sellers, and logistics.

## Functional Requirements

The system shall:
1. Import all source CSV datasets into PostgreSQL.
2. Store raw data in the Landing Layer.
3. Transform raw data into standardized Staging tables.
4. Load validated data into the Data Warehouse.
5. Build Star Schema tables for analytical reporting.
6. Support KPI calculations within Power BI.
7. Provide interactive filtering and drill-down capabilities.
8. Implement Row-Level Security (RLS).
9. Support scheduled dataset refresh simulation.
10. Export business insights through interactive dashboards.

## Non-Functional Requirements

The solution should satisfy the following quality attributes:
- Maintainability through modular SQL scripts.
- Readability using standardized naming conventions.
- Data consistency through validation rules.
- Scalability for future analytical requirements.
- Reproducibility using Git version control.
- Usability through intuitive dashboard design.

## KPI Catalog

| KPI                         | Description                                                    |
|-----------------------------|----------------------------------------------------------------|
| Total Revenue               | Total payment value received                                   |
| Total Orders                | Number of completed orders                                     |
| Average Order Value         | Average revenue per completed order                            |
| Monthly Revenue             | Revenue aggregated by month                                    |
| Order Growth                | Percentage growth of orders over time                          |
| Delivery Lead Time          | Days between purchase and delivery                             |
| On-Time Delivery Rate       | Percentage of orders delivered on or before the estimated date |
| Customer Satisfaction Score | Average review score                                           |
| Active Sellers              | Number of sellers with completed transactions                  |
| Top Selling Categories      | Product categories with the highest sales                      |

## Dashboard Scope

The solution will include the following dashboards:
1. Executive Overview
2. Sales Performance
3. Customer Analysis
4. Product Analysis
5. Seller Performance
6. Logistics Performance

## Business Questions

The Business Intelligence platform should help answer the following questions:
- How is overall business performance evolving over time?
- Which products and categories generate the highest revenue?
- Who are the highest-performing sellers?
- Which regions generate the highest number of orders?
- How satisfied are customers with completed orders?
- How efficient is the delivery process?
- What are the monthly sales and order trends?
- Which KPIs require immediate management attention?

## Success Criteria

The project will be considered successful when:
- All source datasets are successfully integrated into PostgreSQL.
- Data transformation processes produce consistent and validated analytical datasets.
- The Data Warehouse follows a well-designed Star Schema.
- Power BI dashboards answer the predefined business questions.
- KPI calculations are standardized across all reports.
- Dashboard users can analyze business performance without manual data preparation.
- The entire solution is fully documented and reproducible through the GitHub repository.

## Assumptions & Risks

### Assumptions
- The provided dataset accurately represents historical business operations.
- Source data remains unchanged throughout the project.
- PostgreSQL serves as the centralized analytical database.
- Power BI is the primary reporting platform.

### Risks
- Public datasets may contain missing or inconsistent data.
- Business rules cannot be fully validated against the original operational systems.
- The project simulates production practices but is not connected to live operational systems.