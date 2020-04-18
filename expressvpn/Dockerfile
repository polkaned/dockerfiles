
# Run expressvpn in a container

FROM debian:buster-slim
LABEL maintainer "benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ARG APP=eexpressvpn_2.4.5.2-1_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget expect iproute2 curl \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "https://download.expressvpn.xyz/clients/linux/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb \
    && apt-get purge -y --auto-remove wget

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
