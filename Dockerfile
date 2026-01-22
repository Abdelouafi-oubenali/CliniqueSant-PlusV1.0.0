FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/clinique-management-project.war /usr/local/tomcat/webapps/ROOT.war

COPY libs/postgresql-42.6.0.jar /usr/local/tomcat/lib/

EXPOSE 8080

CMD ["catalina.sh", "run"]
