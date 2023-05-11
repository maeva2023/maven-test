# Pull base image 
FROM tomcat:8-jre8 

# Maintainer 
MAINTAINER "dubai@yahoo.fr" 
COPY ./webapp.war /usr/local/tomcat/webapps
