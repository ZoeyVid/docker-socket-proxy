#!/usr/bin/env sh

if [ ! -s /tmp/privkey.pem ] || [ ! -s /tmp/fullchain.pem ]; then
  openssl req -new -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -x509 -days 365000 -nodes -subj '/CN=*' -sha512 -keyout /tmp/privkey.pem -out /tmp/fullchain.pem
fi
if [ ! -s /tmp/cert.pem ]; then
  cat /tmp/fullchain.pem /tmp/privkey.pem > /tmp/cert.pem
fi

exec su-exec "nobody:$(stat -c "%g" "$SOCKET_PATH")" haproxy -f /etc/haproxy/haproxy.cfg -W -db
