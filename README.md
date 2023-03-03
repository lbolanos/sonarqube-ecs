# Sonarqube ECS

## Description

Se pretendía user docker context para que haga el deploy del docker-compose
pero tuvimos problemas al subirlo con FARGATE.  Siempre nos daba error de vm.max_map_count.

Lo que se hizo fue utilizar el convert para crear el yml modificarlo para que use EC2.

Tuvimos problemas también al subir la imagen a ECR por eso utilizamos docker.io

Este proyecto crea la imagen y la sube a docker hub y utiliza aws cli para 
hacer el deploy del archivo cf.yml

utilice make para ver las opciones

```
make
```

Para iniciar el ambiente y subir la imagen

```
make init_ecs
```

Para hacer el deploy


```
make ebex
```

Para verificar la imagen


```
docker run -it -p 8888:9000 docker.io/lbolanos/sonarqubev4:v10 /bin/bash
```

Para borrar las imagenes y los volumenes


```
docker compose down --rmi all --volumes --remove-orphans
```

En el servidor EC2 donde estan las imagenes


```
sudo docker ps
sudo docker container exec -it <ID> /bin/bash
```


## Installation

Create common.env

Example:

```
PRJ="sonarqubev4"
REGION=us-east-1
ACCOUNT=11111111
```


### Links

[Sonarquebe Docker](https://github.com/techforum-repo/docker-projects/blob/master/sonarqube-with-custom-plugins-aem/docker-compose.yml "docker")

[Sonarqube ECS](https://devops4solutions.com/deploy-docker-container-in-ecs-using-docker-compose/ "docker ecs")

[Docker ECS](https://docs.docker.com/cloud/ecs-integration/ "Docker ECS")

[Manual ECS](https://krishnawattamwar.medium.com/serverless-sonarqube-using-aws-ecs-2402b9e4f1f9 "Manual")

https://github.com/Kinjalrk2k/Dockerfile/blob/f9f567f5fcde83e10e5248748bc902a314c5482a/sonarqube/Dockerfile
