FROM openjdk:8-jdk-alpine
COPY target/webdemo-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]