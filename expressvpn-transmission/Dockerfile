
# Run expressvpn and transmission in a container

FROM polkaned/expressvpn:latest
LABEL maintainer "benjamin@polkaned.net"

ENV T_ALLOWED=127.0.0.1

RUN apt-get update && apt-get install -y \
    transmission-daemon \
    && rm -rf /var/lib/apt/lists/*

CMD /usr/bin/transmission-daemon \
    --allowed ${T_ALLOWED} \
    --foreground \
    --encryption-preferred \
    --incomplete-dir /var/lib/transmission-daemon/downloads \
    --dht \
    --download-dir /var/lib/transmission-daemon/downloads
