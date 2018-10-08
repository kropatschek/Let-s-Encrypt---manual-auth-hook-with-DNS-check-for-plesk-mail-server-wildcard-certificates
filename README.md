# Let's Encrypt --manual-auth-hook with DNS check for plesk mail server wildcard certificates


## ussage:

copy dns-authenticator.sh and dns-cleanup.sh to your working directory. 

```bash
./certbot/certbot-auto certonly --manual \
-d example.com \
-d *.example.com \
-d *.example2.com \
--agree-tos --manual-public-ip-logging-ok \
--preferred-challenges dns \
--manual-auth-hook ./dns-authenticator.sh \
--manual-cleanup-hook ./dns-cleanup.sh \
--server https://acme-v02.api.letsencrypt.org/directory
```
## install certificate to plesk:

first create

```bash
plesk bin certificate --create "default" -admin -default \
-key-file /etc/letsencrypt/live/example.com/privkey.pem \
-cert-file /etc/letsencrypt/live/example.com/cert.pem \
-cacert-file /etc/letsencrypt/live/example.com/chain.pem
```

afterwards update 

```bash
plesk bin certificate --update "default" -admin -default \
-key-file /etc/letsencrypt/live/example.com/privkey.pem \
-cert-file /etc/letsencrypt/live/example.com/cert.pem \
-cacert-file /etc/letsencrypt/live/example.com/chain.pem
```
