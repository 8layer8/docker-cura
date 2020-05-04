# Dockerfile
# mkdir -p /root/docker/dockerfiles/dev_workstation
# git clone git@github.disney.com:wdprt-middleware/wdprt_sece_dev_workstation.git
# vi /root/docker/dockerfiles/dev_workstation/Dockerfile
# paste in this file
# run it with:

# source proxy.sh
# docker build -t dev_workstation /root/docker/dockerfiles/dev_workstation/
# docker images
# docker run -d -p 3389:3389 dev_workstation



docker rm cura-docker-test
docker rmi docker-cura
docker build -t mindcrime30/docker-cura:0.0.1 .
# docker images
docker run --rm -p 5805:5800 --name docker-cura-test mindcrime30/docker-cura:0.0.1

# Put version above, and then:
# docker login
# yada yada
# docker push mindcrime30/docker-cura:0.0.1



