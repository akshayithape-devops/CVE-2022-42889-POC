
# Use an Official Maven image to build projects
FROM maven:3.6.3-openjdk-11

# Set the working directory to /app
WORKDIR /app

# Copy the code files into container at /app/src
COPY ./src /app/src

# Copy the build file into container at /app/
COPY ./pom.xml /app

# Build the application/code
RUN mvn clean install

# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jre-alpine

# set shell to bash
RUN apk update && apk add bash nmap-ncat

# Set the working directory to /app
WORKDIR /app

# Copy the fat jar into the container at /app
COPY --from=0 /app/target/text4shell-poc.jar /app

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run jar file when the container launches
CMD ["java", "-jar", "text4shell-poc.jar"]