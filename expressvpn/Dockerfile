

# Run expressvpn in a container

#   docker run -d -t --name expressvpn \
#       --restart always \
#       --cap-add=NET_ADMIN \
#       --device=/dev/net/tun \
#       --privileged \
#       -e ACTIVATION_CODE= \
#       polkaned/expressvpn

FROM debian:buster-slim
LABEL maintainer "benjamin@polkaned.net"

ENV ACTIVATION_CODE Code

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget expect iproute2 \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "https://download.expressvpn.xyz/clients/linux/expressvpn_1.5.0_amd64.deb" -O /tmp/expressvpn_1.5.0_amd64.deb \
    && dpkg -i /tmp/expressvpn_1.5.0_amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove wget

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/usr/bin/bash", "/tmp/entrypoint.sh"]