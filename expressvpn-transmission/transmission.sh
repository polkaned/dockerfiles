#!/usr/bin/bash

param=" --allowed ${T_ALLOWED}"
param="${param} --foreground"
param="${param} --encryption-preferred"
param="${param} --incomplete-dir /var/lib/transmission-daemon/downloads"
param="${param} --dht"
param="${param} --download-dir /var/lib/transmission-daemon/downloads"
if [ -n "$T_USERNAME" ] && [ -n "$T_PASSWORD" ]
then
    param="${param} --auth"
    param="${param} --username ${T_USERNAME}"
    param="${param} --password ${T_PASSWORD}"
else
    param="${param} --no-auth"
fi
/usr/bin/transmission-daemon ${param}
