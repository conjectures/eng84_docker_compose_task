# Docker Compose Task

## Summary
Create the two-tier architecture node app with multiple containers, instead of VMs.

## Acceptance Criteria
- Dockerised node app
- App fully working with database
- Create volume for persistent storage


## Documentation
To run the application on localhost, clone the project on your system.
Change directory inside the project and run:
```
docker-compose build --no-cache
docker-compose up -d
```
The application can be found on your browser with url `localhost:3000` .


## Solution
In order to dockerise the application, a Dockerfile was created. The dockerfile is based on a lightweight version of the [official node image](https://hub.docker.com/_/node)
The files are being copied in the container, then the requirements are installed and the database is seeded and the application is run.
The image node web application image has been pushed to DockerHub and can be found [here](https://hub.docker.com/repository/docker/conjectures/eng84_sparta_app).

However, there are two requirements before the node application can be fully working.
First, the database container needs to be run, and the environment variable `DB_HOST` needs to be set inside the app container.


Both of those requirements are being completed with the `docker-compose`  file:
```
version: "3.9"
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    image: conjectures/eng84_sparta_app:v02
    depends_on:
      - mongodb
    environment:
      DB_HOST: mongodb://mongodb:27017/posts
    ports:
      - 3000:3000
    container_name: sparta_app

  mongodb:
    image: mongo
    restart: always
    volumes:
      - mongodata:/var/lib/mongodb
    container_name: database
    ports:
      - 27017:27017
```
As can be seen, the `depends_on` section is used to specify that the database container needs to be run first.

Then, after the database container is up, the `Dockerfile` for the application is specified, along with the appropriate environment variables.

It should be noted, that due to the docker engine's internal VPC and networking solution, the IP of the database can be substituted with the `service` name.

When the above steps are complete, the `docker-compose.yml` file needs to be build then run in detached mode so that the application can work correclty.


