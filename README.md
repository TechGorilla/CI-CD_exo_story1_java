# Java pipeline
---
Create a directory named "JavaDev/" \
Add a sample maven project "test_app" to test the pipeline build. 

### Create a maven project to test the java builds

Code running in the maven project:

__test_app__
```java
//From the src/main
package com.example;
/**
 * Hello world! with flavour.
 */
public final class App {
    private App() {
    }
    /**
     * Shows the java build works.
     * @param args The arguments of the program.
     */
    public static void main(String[] args) {
        System.out.println("Java pipeline works");
    }
}

```

Check if the build runs without errors

```bash
# compile the project
## You should have "BUILD SUCCESS" visible in your prompt after completion.
mvn compile
# Generate the .jar file
mvn clean package
```
At this level, the maven project builds successfully outside of the pipeline.

### Create a docker image

Create a Dockerfile to generate images for builds:

__Dockerfile__
```Dockerfile
#FROM openjdk:8-jdk-alpine
# Install Maven
RUN apk add --no-cache curl tar bash
ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
RUN mkdir -p /usr/share/maven && \
curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && \
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
# speed up Maven JVM a bit
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
# turn the image into a maven builder
# you just need to append a maven goal to the container at runtime
ENTRYPOINT ["/usr/bin/mvn"]
# ----
# Install project dependencies and keep sources
# make source folder
WORKDIR /usr/src/java_apps
# install maven dependency packages (keep in image)
COPY pom.xml /usr/src/java_apps
# copy other source files (keep in image)
COPY src /usr/src/java_apps/src
# use "clean" goal 
RUN mvn clean
```

Check if the build runs without errors

```Docker
# build the image from the Dockerfile
docker build -t java_dev .
# check the container
docker -run -it java_dev  
# we're just testing, get in , check if the files are copied, run the compile command and exit the container.
``` 

Jenkins

in global tool configuration:add Maven installation "maven_build"