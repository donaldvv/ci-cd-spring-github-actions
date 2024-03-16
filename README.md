# Demo app for CI/CD with GitHub Actions

### Project/Repo level secrets
- Can be defined at Settings -> Secrets and variables -> Actions
- Defined the following secrets at the repo level:
  - `DOCKERHUB_USERNAME`: DockerHub username
  - `DOCKERHUB_TOKEN`: DockerHub

### Environment variables
- To specify distinct environments like dev, staging, prod, we should go to Settings -> Environments
- Here we can specify distinct variables and secrets for specific environments. These will be then accessible by GitHub Actions in the context of the specific environment.
- For example, we can specify the following environment variables for the `dev` environment:
  - `DB_URL`: jdbc:mysql://localhost:3306/dev
  - `DB_USERNAME`: dev_user
  - `DB_PASSWORD`: dev_password

### Docker image tagging strategy
- There are different ways to tag the docker image.
- Some do different repos for dev and prod. Some use "prod" in the tag name etc.
- For this we're using same docker hub repo, and adding the commit sha and curr date as tag name.  
  This way we can always track the exact version of the image that is running in any environment.
- For more see: https://www.reddit.com/r/devops/comments/wnhisp/what_is_your_docker_image_tagging_strategy/

### Separate workflow yaml file per env
- Generally if we have many environments, we need to use single workflow file for example for the deploy pipeline and 
utilize the configured environments: https://stackoverflow.com/questions/76241660/github-action-runner-deploy-2-environments-dev-and-prod-on-a-same-server


### Spring profiles
- We can use spring profiles to specify different configurations for different environments.
- Convention for profile specific properties file: `application-{profile_name}.properties`
- There is a configuration to activate these profiles, which is `spring.profiles.active`  
  We can use a command-line argument to activate the profile.
- The disadvantage of putting profiles in the resource folder is that everyone can see configurations for all the environments, including prod and if 
  we change one value in the profile then we will have to rebuild our application.
- Alternative ways to manage spring boot app configs are:
  - Config Server - repo where we put all config files. this server must be up and running when our app starts (meaning we need 2 apps)
  - AWS parameter store
  - K8S Config Maps - preferred way to manage configuration when running application in K8S


# TODOs:
- Enable HTTPS
- Host the app on one of the hosting platforms, and do it for dev and prod profiles/envs:
  - Back4app
  - Heroku
  - DigitalOcean
- Sonar configuration + include in pipeline, including converage report
- Add a DB: dev and prod - include in the deployment
- Try implementing OAuth2 with Keycloak as Auth Server, and deploy dev Keycloak and prod Keycloak with its own prod DB.
- Try implementing OAuth2 with own Spring Boot Auth Server (this way need only 1 app, instead of additional Keycloak app and additional keycloak DB for prod).
- OpenAPI