# landmark-mysql


## Dockerize app ##
```
docker build -t landmark-mysql .
```

## instantiate docker container ##
First, modify docker.env to set the mysql properties
```
docker run -t -p 3306:3306 --env-file ./docker.env landmark-mysql
```

## start/stop docker container ##
```
docker start/stop [container_id]
```

