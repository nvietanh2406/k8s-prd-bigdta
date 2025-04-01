kubectl exec -it deploy/airflow-webserver -n airflow -- bash -c '
airflow db upgrade && 
airflow users create --username admindta --firstname "Admin" --lastname "Airflow" --role Admin --email "data@dsc.com.vn" --password "Adgjmptw1"
'