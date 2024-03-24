#!/bin/sh
openssl req -nodes -new -x509 -subj '/CN=*' -sha256 -keyout /tmp/privkey.pem -out /tmp/fullchain.pem -days 365000 > /dev/null 2>&1
cat /tmp/fullchain.pem /tmp/privkey.pem | tee /tmp/cert.pem > /dev/null 2>&1
if [ "$NOPOST" = "1" ]; then
haproxy -f /etc/haproxy/haproxy-no-post.cfg -W -db
else
haproxy -f /etc/haproxy/haproxy.cfg -W -db
fi
