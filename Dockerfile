# Create image based on the Temurin Java 21 image
FROM adoptopenjdk:21-jre-hotspot
EXPOSE 8080
ADD target/ci-cd-spring-github-actions.jar ci-cd-spring-github-actions.jar
ENTRYPOINT ["java", "-jar", "/ci-cd-spring-github-actions.jar"]