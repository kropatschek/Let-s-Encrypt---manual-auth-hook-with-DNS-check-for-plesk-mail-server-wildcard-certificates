#!/bin/bash

#CERTBOT_DOMAIN="example.com"
#CERTBOT_VALIDATION="RNPDCzspbEsMcUMxiq3tD_cBLYcxyNmEbqu9XZFXFgE"

# Google
dns_server="8.8.8.8"
#
#dns_server="a.root-servers.net"
max_attempts=20
sleep_time=30
# total time to wait for dns propagation = max_attempts * sleep_time = 20 * 30s = 600s = 10 min

#echo "$CERTBOT_DOMAIN"
#echo "$CERTBOT_VALIDATION"

# create the _acme-challenge txt record
plesk bin dns --add $CERTBOT_DOMAIN -txt "$CERTBOT_VALIDATION" -domain _acme-challenge

attempt_counter=0
while true; do
    if [[ $attempt_counter = $max_attempts ]]; then
        echo "DNS propagation time: $(($attempt_counter*$sleep_time))s"
        echo "Max attempts reached. The creation of the Let's Encrypt cetificate (with dns veefication) will fail"
        break
    fi

    for d in $(dig "@$dns_server" -t txt +short "_acme-challenge.$CERTBOT_DOMAIN"); do
        if [[ "$d" = "\"$CERTBOT_VALIDATION\"" ]]; then
            echo "DNS propagation time: $(($attempt_counter*$sleep_time))s"
            break 2
        fi
    done
    
    attempt_counter=$(($attempt_counter+1))
    
    # Sleep to make sure the change has time to propagate over to DNS
    sleep $sleep_time
done
