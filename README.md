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


# Sample
```
---
version: '3.7'
services:
  cura:
    image: mindcrime30/docker-cura:latest
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    ports:
      - 5800:5800
    volumes:
      - ${VM_STORAGE}/cura/config:/config
      - /mnt/files/3D-Print:/storage
      - ${VM_STORAGE}/cura/output:/output
```

# With traefik
```
---
version: '3.7'
services:
  traefik:
    image: traefik:v1.7.16
    ports:
      - 80:80
      - 443:443
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ${CONFIGFOLDER}/traefik/traefik.toml:/traefik.toml:ro
      - ${CONFIGFOLDER}/traefik/rules.toml:/rules.toml:ro
      - ${LOCALFOLDER}/traefik/acme.json:/acme.json
    labels:
      - traefik.enable=true
      - traefik.frontend.rule=Host:traefik.${LOCALDOMAIN}
      - traefik.port=8080
      - traefik.frontend.entryPoints=https,http
      - traefik.frontend.headers.SSLRedirect=true

  cura:
    image: mindcrime30/docker-cura:latest
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - ${VM_STORAGE}/cura/config:/config
      - /mnt/files/3D-Print:/storage
      - ${VM_STORAGE}/cura/output:/output
    labels:
      - traefik.enable=true
      - traefik.frontend.rule=Host:cura.${LOCALDOMAIN}
      - traefik.port=5800
      - traefik.frontend.entryPoints=https
      - traefik.frontend.headers.SSLRedirect=true
```
