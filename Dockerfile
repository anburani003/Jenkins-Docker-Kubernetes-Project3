FROM docker.io/library/tomcat:8.0.20-jre8@sha256:579e042fb31e6975062276489cbdb3d9c942661a1d489f122d29ce2249e2ed34

RUN mkdir /usr/local/tomcat/webapps/myapp
COPY ./kubernetes/target/kubernetes-1.0-AMIT.war /usr/local/tomcat/webapps/myapp/kubernetes-1.0-AMIT.war
