#!/bin/bash

# ACTIVATION_CODE needs to be set as env var
# export ACTIVATION_CODE={% your-activation-code %}

set -e

echo ""
echo "~> Build script for expressvpn container"
echo ""

echo "~> Get a build id..."
build_id="$(printf '%x' `date +%s`)"
echo "${build_id}"
echo ""

echo "~> Get the expressvpn version..."
expressvpn_version="$(grep 'ARG APP' Dockerfile | cut -d"_" -f2)"
echo "${expressvpn_version}"
echo ""

echo "~> Get the container tag..."
tag=${expressvpn_version}.${build_id}
echo "${tag}"
echo ""

echo "~> Check expressvpn activation code..."
if [ -z "$ACTIVATION_CODE" ]
then
    echo "!! Set ACTIVATION_CODE env var !!"
    exit -1
else
    echo "OK"
fi
echo ""

echo "~> Build the image..."
docker build --pull --no-cache --rm --force-rm -f Dockerfile -t expressvpn:${tag} .
echo ""

echo "~> Delete testing container (if last test failed)..."
set +e
docker stop expressvpn-rc
docker rm expressvpn-rc
set -e
echo ""

echo "~> Run testing container..."
docker run \
    --env=ACTIVATION_CODE=${ACTIVATION_CODE} \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    --privileged \
    --detach=true \
    --tty=true \
    --name=expressvpn-rc \
    expressvpn:${tag} \
    /bin/bash
echo ""

echo "~> Wait expresspvn activation (20s)..."
for i in {1..20}
do
    sleep 1
    echo -n "$i "
done
echo ""

echo ""
echo "~> Check expressvpn status..."
status="$(docker exec -it expressvpn-rc expressvpn status)"
if [[ "$status" == *"Connected to"* ]]
then
    echo "$status" | grep 'Connected to' 
else
    echo "!! Set ACTIVATION_CODE env var !!"
    echo "!! Ouput:"
    echo "$status"
    echo "!!"
    exit -1
fi
tput sgr0
echo ""

echo "~> Delete testing container..."
docker stop expressvpn-rc
docker rm expressvpn-rc
echo ""

read -p "~> Test(s) seem(s) ok. Do you want to update registry with this image?" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 0
fi
echo ""

echo "~> Tag version to registry..."
docker tag expressvpn:${tag} polkaned/expressvpn:${tag}
echo ""

echo "~> Tag lastest to registry..."
docker tag expressvpn:${tag} polkaned/expressvpn
echo ""

echo "~> Push to registry..."
docker push --all-tags polkaned/expressvpn
echo ""

echo "~> Cleaning..."
docker rmi polkaned/expressvpn:latest
docker rmi polkaned/expressvpn:${tag}
docker rmi expressvpn:${tag}
echo ""
