docker run --rm -it --name monitor -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry
