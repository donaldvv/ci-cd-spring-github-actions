FROM maven:3.9.6 AS build
WORKDIR /ci-cd-spring-github-actions
ARG CONTAINER_PORT
COPY pom.xml /ci-cd-spring-github-actions
RUN mvn dependency::resolve
COPY . /ci-cd-spring-github-actions
RUN mvn clean
RUN mvn package -DskipTests -X

# Create image based on the Temurin Java 21 image
# Generally the port and active profile (dev, prod) should be passed as a variable either here, or when image is run
FROM eclipse-temurin:21-alpine
COPY --from=build /ci-cd-spring-github-actions/target/*.jar ci-cd-spring-github-actions.jar
EXPOSE 8080
CMD ["java", "-jar", "ci-cd-spring-github-actions.jar"]