
# Run expressvpn and transmission in a container

FROM polkaned/expressvpn:latest
LABEL maintainer "benjamin@polkaned.net"

RUN apt-get update && apt-get install -y \
    transmission-daemon \
    && rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/transmission-daemon", "--foreground", "--encryption-preferred", "--incomplete-dir", "/var/lib/transmission-daemon/downloads", "--dht", "--download-dir", "/var/lib/transmission-daemon/downloads"]
