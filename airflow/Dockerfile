FROM python:3.7-slim-buster

ARG airflow_version=1.10.10
ARG airflow_home=/airflow
ARG airflow_cfg=./airflow.cfg
ARG mysql_apt_config=0.8.15-1_all
ARG mysql_install_cfg=./mysql-install.cfg

ENV TZ Asia/Tokyo
ENV AIRFLOW_VERSION=${airflow_version}
ENV AIRFLOW_HOME=${airflow_home}
ENV AIRFLOW_CFG=${airflow_cfg}
ENV MYSQL_APT_CONFIG ${mysql_apt_config}
ENV MYSQL_INSTALL_CFG ${mysql_install_cfg}

# Update apt repository
RUN set -x && \
echo 'deb http://ftp.jp.debian.org/debian/ buster main contrib non-free' > sources.list && \
apt-get update

# Install MySQL repository
ADD https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_config}.deb /tmp
COPY ${mysql_install_cfg} /tmp

RUN set -x && \
apt-get install -y wget lsb-release gnupg && \
dpkg -i /tmp/mysql-apt-config_${mysql_apt_config}.deb < /tmp/mysql-install.cfg && \
apt-get update

# Install MySQL client
RUN set -x && \
apt-get install -y mysql-client && \
apt-get clean

# Install Airflow
RUN mkdir ${AIRFLOW_HOME}
WORKDIR ${AIRFLOW_HOME}

COPY ${AIRFLOW_CFG} ./airflow.cfg

RUN set -x && \
apt-get install -y --no-install-recommends build-essential python3-distutils && \
apt-get install -y --no-install-recommends libssl-dev libmysqlclient-dev

RUN pip install apache-airflow[mysql]==${airflow_version}

RUN apt-get clean

COPY ./startup.sh ./

CMD [ "bash", "./startup.sh" ]
