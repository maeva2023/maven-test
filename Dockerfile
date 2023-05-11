# Pull base image 
FROM tomcat:8-jre8 

# Maintainer 
MAINTAINER "dubai@yahoo.fr" 
COPY ./target/webapp.war /usr/local/tomcat/webapps
