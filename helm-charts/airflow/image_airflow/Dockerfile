FROM apache/airflow:2.9.3

# Chuyển sang người dùng root để cài đặt gói hệ thống
USER root
RUN python3 --version
RUN pip3 --version

# Nâng cấp pip và cài đặt các gói hệ thống cần thiết
RUN pip3 install setuptools
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install --upgrade pip setuptools wheel
RUN apt-get update && apt-get install -y \
build-essential \
libffi-dev \
libssl-dev \
libsasl2-dev \
libldap2-dev \
libz-dev \
gcc \
g++ \
python3-dev \
libc6-dev \
wget \
cmake \
liblz4-dev \
pkg-config \
python3-distutils

RUN pip3 uninstall pendulum -y

# Cài đặt librdkafka từ nguồn
RUN wget https://github.com/edenhill/librdkafka/archive/refs/tags/v2.0.0.tar.gz && \
tar -xzf v2.0.0.tar.gz && \
cd librdkafka-2.0.0 && \
./configure --prefix=/usr && \
make && \
make install && \
cd .. && rm -rf librdkafka-2.0.0 v2.0.0.tar.gz


# Cài đặt confluent-kafka
#RUN pip3 install confluent-kafka==2.0.2

# Cài đặt pendulum với phiên bản cụ thể
RUN pip3 install pendulum --no-cache-dir

# Cài đặt các gói OpenMetadata
RUN pip3 install "openmetadata-ingestion[airflow,postgres,tableau,kafka,dremio,s3]" "openmetadata-managed-apis" | tee install_log.txt
RUN pip3 freeze | grep openmetadata
RUN pip3 install minio openpyxl

# Quay lại người dùng airflow
USER airflow