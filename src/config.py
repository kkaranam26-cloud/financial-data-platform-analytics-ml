import os

# Base storage path for the data platform
# This allows the same pipeline to run across different environments

BASE_PATH = os.getenv("BASE_PATH", "/opt/airflow/data")

# Layer paths
BRONZE_PATH = f"{BASE_PATH}/bronze"
SILVER_PATH = f"{BASE_PATH}/silver"
WAREHOUSE_PATH = f"{BASE_PATH}/warehouse"
GOLD_PATH = f"{BASE_PATH}/gold"
FEATURES_PATH = f"{BASE_PATH}/features"
MODELS_PATH = f"{BASE_PATH}/models"
