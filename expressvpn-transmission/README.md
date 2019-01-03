# ExpressVPN and Transmission in a container

## Prerequisites

1. Get your activation code from ExpressVPN web site.

## Download

`docker pull polkaned/expressvpn-transmission`

## Start the container

    docker run \
      --volume=/home/user/Torrents:/var/lib/transmission-daemon/downloads \
      --env=ACTIVATION_CODE={% your-activation-code %} \
      --env=SERVER={% LOCATION/ALIAS/COUNTRY %} \
      --cap-add=NET_ADMIN \
      --device=/dev/net/tun \
      --privileged \
      --detach=true \
      --tty=true \
      --name=expressvpn-transmission \
      polkaned/expressvpn-transmission

## Configuration

### Mount the downloads Volume
Mount a downloads volume to the host for the Transmission working directories (incomplete and download).

`--volume=/home/user/Torrents:/var/lib/transmission-daemon/downloads`

### ACTIVATION_CODE
A mandatory string containing your ExpressVPN activation code.

`ACTIVATION_CODE=ABCD1EFGH2IJKL3MNOP4QRS`

### SERVER
A optionnal string containing the ExpressVPN server LOCATION/ALIAS/COUNTRY. Connect to smart location if it is not set.

`SERVER=ukbe`
