
# Run expressvpn in a container

FROM debian:trixie-slim AS expressvpn-base

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE=code
ENV REGION=smart
ENV PROTOCOL=auto

ARG APP=expressvpn-linux-universal-14.2.0.13656_release.run

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 iputils-ping \
    curl procps libnm0 iptables psmisc libatomic1 libglib2.0-0 libbrotli1 libdbus-1-3 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q "https://www.expressvpn.works/clients/linux/${APP}" -O /tmp/${APP}
COPY expressvpnInstall.sh /tmp/expressvpnInstall.sh
RUN /usr/bin/expect /tmp/expressvpnInstall.sh \
    && rm -rf /tmp/${APP} \
    && apt-get purge -y --auto-remove wget

COPY entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

FROM expressvpn-base AS expressvpn-wo-iptables

RUN apt-get remove -y iptables
