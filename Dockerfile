FROM maven:3.9.3 AS build
WORKDIR /ci-cd-spring-github-actions
ARG CONTAINER_PORT
COPY pom.xml /ci-cd-spring-github-actions
RUN mvn dependency::resolve
COPY . /ci-cd-spring-github-actions
RUN mvn clean
RUN mvn package - DskipTests -X

# Create image based on the Temurin Java 21 image
FROM eclipse-temurin:21
COPY --from=build /ci-cd-spring-github-actions/target/*.jar ci-cd-spring-github-actions.jar
EXPOSE ${CONTAINER_PORT}
CMD ["java", "-jar", "ci-cd-spring-github-actions.jar"]