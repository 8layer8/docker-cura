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

# Docker Swarm
```
version: '3.7' 
services: 
  cura: 
    image: mindcrime30/docker-cura:4.12.0 
    environment: 
      - PUID=1020
      - PGID=1020
      - TZ=America/New_York
    networks:
      - net
#      - traefik-public
    ports: 
      - 5800:5800
      # Internal only, access it at any node ip:5800
    volumes: 
      - /mnt/pool_alpha/vm_storage/cura/config:/config 
      - /mnt/pool_alpha/shared:/storage 
      - /mnt/pool_alpha/vm_storage/cura/output:/output
    deploy:
      labels:
        - needs.something.to.deploy=true
        # My Cura is INTERNAL only
        # - traefik.enable=true
        # - traefik.docker.network=traefik-public
        # - traefik.constraint-label=traefik-public
        # - traefik.http.routers.cura-http.rule=Host(`${DOMAIN?Variable not set}`)
        # - traefik.http.routers.cura-http.entrypoints=http
        # - traefik.http.routers.cura-http.middlewares=https-redirect
        # - traefik.http.routers.cura-https.rule=Host(`${DOMAIN?Variable not set}`)
        # - traefik.http.routers.cura-https.entrypoints=https
        # - traefik.http.routers.cura-https.tls=true
        # - traefik.http.routers.cura-https.tls.certresolver=le
        # - traefik.http.services.cura.loadbalancer.server.port=5800

networks:
  net:
    driver: overlay
    attachable: true
#  traefik-public:
#    external: true

```
