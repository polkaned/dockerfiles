#!/bin/bash

# ACTIVATION_CODE needs to be set as env var
# export ACTIVATION_CODE={% your-activation-code %}

set -e

echo ""
echo "~> Build script for expressvpn-transmission container"
echo ""

echo "~> Get a build id..."
build_id="$(printf '%x' `date +%s`)"
echo "${build_id}"
echo ""

echo "~> Get the container tag..."
tag=${build_id}
echo "${tag}"
echo ""

echo "~> Build the image..."
docker build --pull --no-cache --rm --force-rm -f Dockerfile -t expressvpn-transmission:${tag} .
echo ""

echo "~> Tag version to registry..."
docker tag expressvpn-transmission:${tag} polkaned/expressvpn-transmission:${tag}
echo ""

echo "~> Tag lastest to registry..."
docker tag expressvpn-transmission:${tag} polkaned/expressvpn-transmission
echo ""

echo "~> Push to registry..."
docker push --all-tags polkaned/expressvpn-transmission
echo ""

echo "~> Cleaning..."
docker rmi polkaned/expressvpn-transmission:latest
docker rmi polkaned/expressvpn-transmission:${tag}
docker rmi expressvpn-transmission:${tag}
echo ""
