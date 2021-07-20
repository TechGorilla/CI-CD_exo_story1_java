# Java pipeline
---
Create a directory named "JavaDev/" \
Add a sample maven project "test_app" to test the pipeline build. \


Code running in the maven build:
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
mvn compile
## You should have "BUILD SUCCESS" visible in your prompt after completion.
```

Create a Dockerfile to generate images for builds. 
__Dockerfile__
```Dockerfile
# Get the official maven container 
FROM maven
# Set the directory to use for the apps
WORKDIR /apps
# Copy ANY java app in this directory to the container /apps directory.
COPY ./test_app .
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