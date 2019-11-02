#!/bin/bash

DOCKER_ID_USER="lozachmp"

directories=(*/)
for ((i=${#directories[@]}-1 ; i>=0 ; i--)) ; do
    directory="${directories[i]}"
    image=${directory%?}
    echo "#### ${image} ####"
    docker build --pull --rm --force-rm --tag ${image} ${image}/.
    docker tag ${image} ${DOCKER_ID_USER}/${image}
    docker push ${DOCKER_ID_USER}/${image}
done
