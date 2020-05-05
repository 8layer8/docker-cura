# docker-cura
Cura 3D in a Docker container, Web UI

```
docker rm cura-docker-test
docker rmi cura-docker
docker build -t cura-docker .
docker images
docker run --rm -p 5805:5800 -name cura-docker-test cura-docker
```

Mount /config, /storage and /output as persistent volumes


