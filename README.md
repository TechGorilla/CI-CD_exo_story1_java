### Java pipeline

Create a directory named "JavaDev/" in the "Story1/" directory.\
Add a sample code "TestApp.java" to test the pipeline build. 

__TestApp.java__
```java
//This is like putting glasses on the HelloWorld app. (blame Superman)
package Story1.JavaDev;

class TestApp {
    public static void main(String[] args) {
        System.out.println("The Java side works!"); 
    }
}
```
Create a Dockerfile to generate images for builds. 

__Dockerfile__
```Dockerfile
# Get the official java container 
FROM openjdk
# Set the directory to use for the apps
WORKDIR /apps
# Copy ANY java app in this directory to the container /apps directory.
COPY ./*.java .
```

jenkins

in global tool configuration:add Maven installation "maven_build"