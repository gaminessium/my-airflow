# apache-airflow 1.10.10

FROM python:3.7-slim-buster

ARG airflow_home=/airflow
ARG airflow_cfg=./airflow.cfg

ENV TZ Asia/Tokyo
ENV AIRFLOW_HOME=${airflow_home}
ENV AIRFLOW_CFG=${airflow_cfg}

RUN mkdir ${AIRFLOW_HOME}
WORKDIR ${AIRFLOW_HOME}

COPY ${AIRFLOW_CFG} ./airflow.cfg

# apt リポジトリの更新
RUN set -x && \
echo 'deb http://ftp.jp.debian.org/debian/ buster main contrib non-free' > sources.list && \
apt-get update

RUN set -x && \
apt-get install -y --no-install-recommends build-essential python3-distutils && \
apt-get clean

RUN set -x && \
pip install apache-airflow

RUN airflow initdb

ENTRYPOINT [ "airflow" ]

CMD ["webserver"]
