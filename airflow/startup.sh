# Initialize Airflow
airflow initdb

# Start webserver & scheduler
bash -c "airflow webserver & airflow scheduler"
