# Financial Data Platform Architecture

## Overview

This project implements a **financial data platform** designed to support analytics, machine learning workloads, and business intelligence use cases.

The platform ingests transactional data, processes it through a layered data architecture, and produces curated datasets for analysts, data scientists, and downstream applications.

The architecture follows modern **data lakehouse principles**, where raw data is progressively refined into structured datasets used for analytics and machine learning.

Core technologies used in the platform:

- Apache Spark for distributed data processing
- Apache Airflow for workflow orchestration
- Python for pipeline implementation
- Parquet for analytical storage

The platform is designed to support multiple workloads including:

- business analytics
- reporting
- machine learning pipelines

---

# System Architecture

The platform follows a layered architecture used in modern data engineering systems.

```
Data Sources
      ↓
Bronze Layer (Raw Data Ingestion)
      ↓
Silver Layer (Cleaned and Standardized Data)
      ↓
Dimensional Warehouse Layer
      ↓
Gold Analytics Layer
      ↓
Feature Engineering
      ↓
Machine Learning Workloads
```

Each layer progressively improves data quality and prepares it for different types of consumers.

Primary consumers include:

- Business analysts
- Data scientists
- Machine learning models
- BI dashboards

---

# Data Processing Layer

The core processing engine used in the platform is **Apache Spark**.

Spark is responsible for:

- ingesting raw data
- transforming datasets
- building warehouse tables
- generating machine learning features
- training ML models

Spark enables distributed computation and scalable processing of large transactional datasets.

All processing jobs are implemented as **Spark batch jobs written in Python**.

---

# Pipeline Orchestration

The platform pipelines are orchestrated using **Apache Airflow**.

Airflow manages:

- workflow scheduling
- task dependencies
- pipeline execution order
- monitoring and retries

The Airflow DAG ensures that each pipeline stage runs only after its upstream dependencies have completed successfully.

Typical pipeline execution order:

```
bronze_ingestion
      ↓
silver_transformations
      ↓
warehouse_modeling
      ↓
gold_analytics_generation
      ↓
data_quality_validation
      ↓
feature_engineering
      ↓
machine_learning_training
      ↓
fraud_scoring
```

This orchestration layer guarantees reliable and reproducible data workflows.

---

# Bronze Layer

The **Bronze Layer** stores raw ingested data.

Purpose of this layer:

- preserve original source data
- maintain immutable records
- act as the source of truth

Characteristics of bronze data:

- minimal transformations
- append-only ingestion
- schema preservation

This layer ensures that raw transactional events are always retained.

---

# Silver Layer

The **Silver Layer** performs data cleaning and normalization.

Responsibilities include:

- schema standardization
- null handling
- data validation
- data enrichment

The goal of the silver layer is to produce **clean, reliable datasets** suitable for analytics and modeling.

Datasets produced in this layer become the foundation for downstream warehouse modeling.

---

# Dimensional Warehouse Layer

The platform implements a **dimensional warehouse model** to support analytical workloads.

Dimensional modeling organizes data into:

- fact tables
- dimension tables

Fact tables capture measurable business events.

Dimension tables provide descriptive attributes used for filtering and grouping.

Core warehouse tables include:

Fact Table

```
fact_transactions
```

Dimension Tables

```
dim_customer
dim_date
```

This modeling approach enables efficient analytical queries and supports business reporting.

---

# Gold Analytics Layer

The **Gold Layer** provides curated datasets optimized for analytics.

These datasets are derived from warehouse tables and represent aggregated or business-ready views.

Examples include:

```
gold_daily_transaction_summary
gold_monthly_revenue_summary
gold_customer_activity_summary
gold_fraud_rate_by_day
```

The gold layer is designed for:

- business reporting
- dashboard development
- analytics exploration

Analysts interact primarily with datasets from this layer.

---

# Feature Engineering Layer

The feature engineering layer prepares datasets used for machine learning.

Features are derived from warehouse tables and capture behavioral patterns in the transaction data.

Examples of engineered features:

- transaction recency
- rolling spending metrics
- fraud ratios
- customer lifetime statistics
- transaction velocity

These features are stored in feature datasets used by machine learning models.

---

# Machine Learning Workloads

The platform supports ML pipelines built on top of engineered features.

A sample ML workload included in this project is **fraud detection**.

Models evaluated:

- Logistic Regression
- Gradient Boosted Trees (GBT)

The ML pipeline performs:

- training dataset generation
- model training
- model evaluation and comparison
- model selection
- fraud scoring

The selected production model is implemented in:

```
fraud_model_gbt_final_v3.py
```

The trained model is applied to transaction data through a scoring pipeline.

---

# Data Quality Validation

Data quality checks are integrated into the pipeline to ensure reliability of downstream datasets.

Validation checks include:

- dataset availability
- schema validation
- column integrity
- basic consistency checks

These checks prevent corrupted or incomplete datasets from propagating through the platform.

---

# Platform Storage Layout

The platform organizes data into logical layers using a configurable base path.

```
BASE_PATH/

bronze/
silver/
warehouse/
gold/
features/
models/
```

Using a configurable base path allows the pipeline to run in different environments including:

- local development environments
- cloud object storage
- distributed data platforms

---

# Summary

The Financial Data Platform implements a layered architecture supporting analytics and machine learning workloads.

By separating data into Bronze, Silver, Warehouse, and Gold layers, the platform ensures:

- scalable data processing
- reliable data quality
- reusable datasets
- clear data lineage

This architecture allows organizations to build robust data-driven applications while maintaining efficient and scalable data pipelines.
