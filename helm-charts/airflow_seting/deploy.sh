helm repo add apache-airflow https://airflow.apache.org
kubectl create ns airflow
kubectl apply -n airflow -f airflow-ssh-git-secret.yaml
kubectl apply -n airflow -f airflow-worker-crb.yaml
kubectl create secret generic airflow-db --from-literal=connection=postgresql://airflow:Adgjmptw1@satellite.stackgres.svc.cluster.local:5432/airflow -n airflow
kubectl create secret generic webserver-secret --from-literal="webserver-secret-key=$(python3 -c 'import secrets; print(secrets.token_hex(16))')" -n airflow
helm upgrade --install -n airflow --create-namespace airflow apache-airflow/airflow --version 1.8.0 -f values.yaml