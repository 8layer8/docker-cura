# run it with:

# source proxy.sh

docker rm cura-docker-test
docker rmi docker-cura
docker build -t mindcrime30/docker-cura:0.0.1 .

# docker images
docker run --rm -p 5805:5800 --name docker-cura-test mindcrime30/docker-cura:0.0.1

# Put version above, and then:
# docker login
# yada yada
# docker push mindcrime30/docker-cura:0.0.1



