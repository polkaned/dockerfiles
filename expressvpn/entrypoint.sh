#!/usr/bin/bash

cp /etc/resolv.conf /tmp/resolv.conf
su -c 'umount /etc/resolv.conf'
cp /tmp/resolv.conf /etc/resolv.conf

nohup /opt/expressvpn/bin/expressvpn-daemon 2>&1 >/dev/null &
until expressvpnctl status >/dev/null 2>&1; do
  sleep 1
done

expressvpnctl background enable
expressvpnctl set networklock true
expressvpnctl set autoconnect true
expressvpnctl set region $REGION
expressvpnctl set protocol $PROTOCOL
expressvpnctl login <(echo "$ACTIVATION_CODE")
expressvpnctl connect $SERVER

exec "$@"
