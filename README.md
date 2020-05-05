# docker-cura
Cura 3D in a Docker container, Web UI

```
docker rm docker-cura-test
docker rmi docker-cura
docker build -t docker-cura .
docker images
docker run --rm -p 5805:5800 -name docker-cura-test docker-cura
```

Mount /config, /storage and /output as persistent volumes
