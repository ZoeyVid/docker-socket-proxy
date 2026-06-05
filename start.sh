#!/usr/bin/env sh

if [ ! -s /tmp/privkey.pem ] || [ ! -s /tmp/fullchain.pem ]; then
  openssl req -new -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -x509 -days 365000 -nodes -subj '/CN=*' -sha512 -keyout /tmp/privkey.pem -out /tmp/fullchain.pem
fi
if [ ! -s /tmp/cert.pem ]; then
  cat /tmp/fullchain.pem /tmp/privkey.pem > /tmp/cert.pem
fi

PGID="$(stat -c "%g" "$SOCKET_PATH")"

if [ -n "$(getent group "$PGID" 2>/dev/null)" ]; then
    :
elif [ -n "$(getent group dsp 2>/dev/null)" ]; then
    groupmod -g "$PGID" dsp
else
    groupadd -g "$PGID" dsp
fi

exec su-exec "nobody:$PGID" haproxy -f /etc/haproxy/haproxy.cfg -W -db
