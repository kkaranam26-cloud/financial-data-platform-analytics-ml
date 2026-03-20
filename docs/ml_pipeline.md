# Machine Learning Pipeline – Fraud Detection

## Project Context

This project implements a production-style financial data platform designed to support analytics, reporting, and machine learning workloads.

The platform processes financial transaction data through multiple layers, transforming raw data into structured datasets that are consumed by downstream systems, including machine learning pipelines.

The machine learning component focuses on building a fraud detection system capable of identifying potentially fraudulent transactions based on behavioral and transactional patterns.

Data Platform Flow:

Financial Transactions  
→ Bronze Layer (Raw Data)  
→ Silver Layer (Cleaned Data)  
→ Warehouse Layer (Dimensional Modeling)  
→ Gold Layer (Analytics Tables)  
→ Feature Engineering Layer  
→ Machine Learning Pipeline  


## ML Pipeline Overview

The fraud detection system is implemented as a multi-stage machine learning pipeline with clear separation between experimentation, evaluation, and production.

Pipeline Flow:

Feature Engineering  
↓  
Training Dataset Construction  
↓  
Model Experimentation  
↓  
Hyperparameter Tuning  
↓  
Model Evaluation  
↓  
Threshold Optimization  
↓  
Final Production Model  


## Training Dataset

The training dataset is generated from the feature engineering layer and consists of aggregated behavioral features derived from transaction data.

Key features include:

- Transaction features: amount, avg_transaction_amount, log_amount  
- Velocity features: transactions_last_7d, total_spent_last_7d  
- Fraud behavior features: fraud_count_last_7d, fraud_ratio_last_7d, fraud_ratio  
- Customer features: total_transactions, total_spent, total_fraud_count  
- Derived features: amount_vs_avg, amount_vs_7d_avg, amount_x_fraud_ratio, velocity_x_fraud_ratio  

These features capture customer behavior, transaction patterns, and historical fraud signals.


## Target Variable

fraud_flag

0 → Legitimate transaction  
1 → Fraudulent transaction  


## Model Experimentation

Two models were evaluated:

- Logistic Regression (baseline model)  
- Gradient Boosted Trees (GBT)  

Logistic Regression provided a simple baseline but was limited due to its linear assumptions.

Gradient Boosted Trees were selected as the final model because they capture nonlinear relationships and interactions between behavioral features.


## Hyperparameter Tuning

Model performance was improved through tuning key parameters:

- maxDepth  
- maxIter  
- stepSize  

Final configuration:

maxDepth = 3  
maxIter = 50  
stepSize = 0.1  


## Model Evaluation

The primary evaluation metric used:

PR-AUC (Precision-Recall Area Under Curve)

This metric is preferred for fraud detection because the dataset is highly imbalanced.

Example performance:

PR-AUC ≈ 0.81  


## Probability Extraction

Spark ML outputs probabilities as:

[probability_non_fraud, probability_fraud]

Fraud probability is extracted using:

vector_to_array(probability)[1]

This value represents the likelihood of a transaction being fraudulent.


## Threshold Optimization

Default classification threshold (0.5) is not suitable for fraud detection.

To improve performance, threshold optimization was implemented.

Process:

Generate prediction probabilities  
↓  
Compute precision-recall curve  
↓  
Calculate F1 score for all thresholds  
↓  
Select threshold with highest F1  

Example result:

Optimal Threshold ≈ 0.36  
Best F1 Score ≈ 0.91  

This significantly improves the balance between precision and recall.


## Production Design (Config-Driven)

All model configuration is stored in:

/opt/airflow/data/models/v3_gbt_final/parameters.json

Example:

{
  "model_type": "GBTClassifier",
  "maxDepth": 3,
  "maxIter": 50,
  "stepSize": 0.1,
  "seed": 42,
  "optimal_threshold": 0.36
}

The final model dynamically loads this configuration instead of using hardcoded values.

This ensures:

- reproducibility  
- consistency across runs  
- easier updates  
- production readiness  


## Final Model Behavior

The final production pipeline performs:

Load parameters.json  
↓  
Train model using configured parameters  
↓  
Generate fraud probabilities  
↓  
Apply optimized threshold  
↓  
Generate final predictions  


## Prediction Logic

fraud_probability > optimal_threshold → fraud_prediction  


## Output

Predictions are stored in:

data/predictions/fraud_predictions_v3/

Each record includes:

- fraud_probability  
- fraud_prediction  
- fraud_flag  


## Model Artifacts

The pipeline generates and stores:

- trained model  
- parameters.json  
- metrics.json  
- feature_importance.json  
- model_metadata.json  


## Pipeline Orchestration

The ML pipeline is designed to be orchestrated using Apache Airflow.

Execution flow:

Feature Engineering  
↓  
Model Training  
↓  
Threshold Optimization  
↓  
Final Model Execution  

This enables automation, scheduling, and monitoring of the full ML workflow.


## Platform Capabilities

This project implements several advanced ML engineering practices:

- Behavioral feature engineering using temporal and aggregated data  
- Handling of class imbalance during experimentation  
- Hyperparameter tuning for model optimization  
- Threshold optimization using precision-recall and F1 scoring  
- Config-driven pipeline design (no hardcoding)  
- Separation of training, evaluation, and production stages  


## Extensions

The platform can be further extended with:

- Model monitoring and drift detection  
- Real-time fraud detection using streaming pipelines  


## Summary

This project demonstrates a complete end-to-end machine learning pipeline integrated into a data platform.

It includes:

- feature engineering  
- model experimentation  
- hyperparameter tuning  
- threshold optimization  
- production deployment design  
- orchestration readiness with Airflow  

The final system is designed not just to train a model, but to operate as a scalable and production-ready fraud detection platform.
