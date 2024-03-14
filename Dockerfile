FROM maven:3.9.3 AS build
WORKDIR /app
ARG CONTAINER_PORT
COPY pom.xml /app
RUN mvn dependency::resolve
COPY . /app
RUN mvn clean
RUN mvn package - DskipTests -X

# Create image based on the Temurin Java 21 image
FROM eclipse-temurin:21
COPY --from=build /app/target/*.jar app.jar
EXPOSE ${CONTAINER_PORT}
CMD ["java", "-jar", "app.jar"]