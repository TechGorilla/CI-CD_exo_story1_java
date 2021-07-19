# get the official java container 
FROM openjdk
# Set the directory to use for the app
WORKDIR /apps
# Copy ANY java app in this directory to the container /apps directory.
COPY ./demo/ .