
# Run expressvpn in a container

#   docker run -d -t --name expressvpn \
#       --cap-add=NET_ADMIN \
#       --device=/dev/net/tun \
#       --privileged \
#       -e ACTIVATION_CODE= \
#       polkaned/expressvpn
#       /bin/bash

FROM debian:buster-slim
LABEL maintainer "benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ARG APP=expressvpn_1.5.1_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget expect iproute2 \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "https://download.expressvpn.xyz/clients/linux/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb \
    && apt-get purge -y --auto-remove wget

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/usr/bin/bash", "/tmp/entrypoint.sh"]