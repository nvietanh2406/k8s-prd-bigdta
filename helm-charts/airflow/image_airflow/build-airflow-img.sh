# sample with dockerhub harbor local
docker build -t dockerhub.dsc.com.vn/dsc_datawarehouse/airflow:2.9.3-openmetadata-1.1.1.0-minio .
docker push dockerhub.dsc.com.vn/dsc_datawarehouse/airflow:2.9.3-openmetadata-1.1.1.0-minio
