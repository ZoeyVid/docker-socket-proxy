#!/bin/sh
openssl req -nodes -new -x509 -subj '/CN=*' -sha256 -keyout /etc/privkey.pem -out /etc/fullchain.pem -days 365000 > /dev/null 2>&1
cat /etc/fullchain.pem /etc/privkey.pem | tee /etc/cert.pem > /dev/null 2>&1
if [ "$NOPOST" = "1" ]; then
haproxy -f /etc/haproxy/haproxy-no-post.cfg -d
else
haproxy -f /etc/haproxy/haproxy.cfg -d
fi
