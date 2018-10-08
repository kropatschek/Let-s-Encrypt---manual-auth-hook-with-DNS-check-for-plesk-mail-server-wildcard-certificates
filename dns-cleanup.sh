#!/bin/bash

#echo "$CERTBOT_DOMAIN"

plesk bin dns --del "$CERTBOT_DOMAIN" -txt "$CERTBOT_VALIDATION" -domain _acme-challenge
