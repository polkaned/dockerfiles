#!/usr/bin/expect
spawn expressvpn activate
expect "code:"
send "$env(ACTIVATION_CODE)\r"
echo "Activating code sent"
expect "information."
send "n\r"
expect eof
