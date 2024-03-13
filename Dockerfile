# Create image based on the Temurin Java 21 image
FROM eclipse-temurin:21
EXPOSE 8080
ADD target/ci-cd-spring-github-actions.jar ci-cd-spring-github-actions.jar
ENTRYPOINT ["java", "-jar", "/ci-cd-spring-github-actions.jar"]