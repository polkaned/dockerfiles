# ExpressVPN in a container

This container should be used as base layer.

## Prerequisites

1. Get your activation code from ExpressVPN web site.

## Download

`docker pull polkaned/expressvpn`

## Start the container

    docker run \
      --env=ACTIVATION_CODE={% your-activation-code %} \
      --cap-add=NET_ADMIN \
      --device=/dev/net/tun \
      --privileged \
      --detach=true \
      --tty=true \
      --name=expressvpn \
      polkaned/expressvpn \
      /bin/bash

## Configuration Reference

### ACTIVATION_CODE
A string containing your ExpressVPN activation code.

`ACTIVATION_CODE=ABCD1EFGH2IJKL3MNOP4QRS`
