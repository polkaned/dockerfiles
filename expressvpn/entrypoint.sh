#!/usr/bin/bash

cp /etc/resolv.conf /tmp/resolv.conf
su -c 'umount /etc/resolv.conf'
cp /tmp/resolv.conf /etc/resolv.conf
sed -i 's/DAEMON_ARGS=.*/DAEMON_ARGS=""/' /etc/init.d/expressvpn
service expressvpn restart
sleep 5 #wait for service to start to see if it has already been activated
if expressvpn status | grep -q "Not Activated"
then
    /usr/bin/expect /tmp/expressvpnActivate.sh
    x=1 #sleep for up to 60 seconds while the activate script runs
    while [ $x -le 60 ]
    do
    if expressvpn status | grep -q "Not Activated"
    then
        sleep 1
    else
        x=61
    fi
    x=$(( $x + 1 ))
    done
fi
if expressvpn status | grep -q "Not Activated"
then
    echo "Failed to activate"
    exit 1 #restart the container if actiavation failed
elif expressvpn status | grep -q "Not connected"
then
    echo "Initating Connection"
    expressvpn status
    expressvpn preferences set auto_connect true
    expressvpn preferences set preferred_protocol $PREFERRED_PROTOCOL
    expressvpn preferences set lightway_cipher $LIGHTWAY_CIPHER
    expressvpn connect $SERVER
    exec "$@"
else
    sleep 5
    expressvpn status
    exec "$@"
fi