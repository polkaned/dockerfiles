
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto

ARG APP=expressvpn_3.57.0.3-1_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 iputils-ping curl procps libnm0 \
    && wget -q "https://www.expressvpn.works/clients/linux/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb \
    && apt-get update && apt-get upgrade -y expressvpn \
    && apt-get purge -y --auto-remove wget \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
