# Machine Learning Workloads

The platform supports machine learning pipelines built on top of engineered features generated from transactional data.

This project includes a sample ML workload demonstrating fraud detection using Spark MLlib.

The purpose of this workload is to show how the data platform can support machine learning experimentation and model deployment.

---

# Training Dataset

The training dataset is generated from engineered features derived from transaction data.

Feature generation pipelines compute behavioral metrics such as:

- transaction recency
- rolling spending metrics
- fraud ratios
- customer transaction velocity
- lifetime transaction statistics

These features are stored as datasets used for model training.

---

# Models Evaluated

Two machine learning models were evaluated for fraud prediction:

- Logistic Regression
- Gradient Boosted Trees (GBT)

Logistic Regression provides a simple and interpretable baseline model.

Gradient Boosted Trees capture nonlinear patterns and interactions in transaction behavior.

---

# Model Selection

After evaluation, Gradient Boosted Trees (GBT) was selected as the primary model due to improved performance during model evaluation.

The production model is implemented in:

```
fraud_model_gbt_final_v3.py
```

---

# ML Pipeline Steps

The ML workflow includes the following steps:

1. training dataset generation
2. feature engineering
3. model training
4. model evaluation and comparison
5. model selection
6. fraud scoring

---

# Fraud Scoring

The trained model is applied to transaction data using the scoring pipeline:

```
fraud_scoring_gold_v1.py
```

The scoring process produces fraud prediction probabilities that can be used for downstream analysis and monitoring.

---

# Role of ML in the Platform

Fraud detection in this project serves as a demonstration of how the data platform supports machine learning workloads.

The platform architecture allows ML pipelines to operate on curated datasets produced by the analytics pipeline.
