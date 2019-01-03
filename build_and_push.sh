#!/bin/bash

DOCKER_ID_USER="polkaned"

for directory in */; do
    image=${directory%?}
    echo "${image}"
    docker build --pull --rm --force-rm --tag ${image} ${image}/.
    docker tag ${image} ${DOCKER_ID_USER}/${image}
    docker push ${DOCKER_ID_USER}/${image}
done
