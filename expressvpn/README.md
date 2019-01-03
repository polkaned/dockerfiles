# ExpressVPN in a container

This container should be used as base layer.

## Prerequisites

1. Get your activation code from ExpressVPN web site.

## Download

`docker pull polkaned/expressvpn`

## Start the container

    docker run \
      --env=ACTIVATION_CODE={% your-activation-code %} \
      --env=SERVER={% LOCATION/ALIAS/COUNTRY %} \
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
A mandatory string containing your ExpressVPN activation code.

`ACTIVATION_CODE=ABCD1EFGH2IJKL3MNOP4QRS`

### SERVER
A optionnal string containing the ExpressVPN server LOCATION/ALIAS/COUNTRY. Connect to smart location if it is not set.

`SERVER=ukbe`
