FROM bde2020/flink-maven-template:0.10.1-hadoop2.7

MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

#ENV FLINK_APPLICATION_JAR_LOCATION /usr/src/app/target/flink-starter-0.0.1-SNAPSHOT.jar
ENV FLINK_APPLICATION_JAR_NAME flink-starter-0.0.1-SNAPSHOT
ENV FLINK_APPLICATION_ARGS ""
