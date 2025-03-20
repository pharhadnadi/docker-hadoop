FROM debian:latest

LABEL "Maintainer"="Ivan Ermilov<ivan.s.ermilov@gmail.com>"
LABEL "Maintainer"="Giannis Mouchakis<gmouchakis@iit.demokritos.gr>"
LABEL "Maintainer"="Farhad Nadi<farhad.nadi@gmail.com>"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y --no-install-recommends 

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
RUN apt-add-repository 'deb http://deb.debian.org/debian/ sid main'

RUN apt-get -y update

RUN apt-get install -y   openjdk-8-jdk 
RUN apt-get install -y   netcat-traditional 

RUN apt-get install -y   net-tools 
RUN apt-get install -y   curl 
RUN apt-get install -y  gnupg 
RUN apt-get install -y  libsnappy-dev
RUN apt-get install -y python3


RUN rm -rf /var/lib/apt/lists/*
      
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION=3.2.4
ENV HADOOP_URL=https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=$HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

