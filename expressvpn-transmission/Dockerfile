
# Run expressvpn and transmission in a container

FROM polkaned/expressvpn:latest
LABEL maintainer="benjamin@polkaned.net"

ENV T_ALLOWED=127.0.0.1
ENV T_USERNAME=
ENV T_PASSWORD=

RUN apt-get update && apt-get install -y \
    transmission-daemon \
    && rm -rf /var/lib/apt/lists/*

COPY transmission.sh /tmp/transmission.sh

CMD ["/bin/bash", "/tmp/transmission.sh"]
