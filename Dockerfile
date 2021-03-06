## Build stage
FROM maven:3.6-jdk-8 AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package
## Package stage
FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/test_app-1.0.jar /usr/app/test_app-1.0.jar  
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/test_app-1.0.jar"]  