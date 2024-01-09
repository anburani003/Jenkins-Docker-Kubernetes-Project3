FROM docker.io/library/tomcat:8.0.20-jre8

RUN mkdir /usr/local/tomcat/webapps/myapp
COPY kubernetes/target/kubernetes-1.0-AMIT.war /usr/local/tomcat/webapps/myapp/kubernetes-1.0-AMIT.war
