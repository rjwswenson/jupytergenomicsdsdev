FROM quay.io/occ_data/jupyternotebook:1.9.1
USER root

RUN apt-get update
RUN apt-get install openjdk-8-jdk
WORKDIR /usr/local

#LIB DEPENDENCIES
RUN apt-get install -y liblz4-tool && apt-get install -y liblz4-dev

#UTILITIES
RUN apt-get install -y wget && apt-get -y install git
RUN wget -r https://services.gradle.org/distributions/gradle-4.10.2-bin.zip && unzip services.gradle.org/distributions/gradle-4.10.2-bin.zip
RUN wget -r http://archive.cloudera.com/spark2/parcels/latest/SPARK2-2.4.0.cloudera2-1.cdh5.13.3.p0.1041012-xenial.parcel && tar xvf archive.cloudera.com/spark2/parcels/latest/SPARK2-2.4.0.cloudera2-1.cdh5.13.3.p0.1041012-xenial.parcel

#HAIL Source
WORKDIR /usr/local
RUN git clone https://github.com/hail-is/hail.git
RUN ls -al

RUN export SPARK_HOME=/usr/local/archive.cloudera.com/spark2/parcels/latest/SPARK2-2.4.0.cloudera2-1.cdh5.13.3.p0.1041012-xenial.parcel
RUN export PATH=$PATH:/usr/local/services.gradle.org/distributions/gradle-4.10.2/bin
RUN ls -al
WORKDIR /usr/local/hail/hail
RUN make install-on-cluster HAIL_COMPILE_NATIVES=1 SPARK_VERSION=2.4.0 PY4J_VERSION=0.10.7



