#!/bin/sh -e

http_proxy_conf=
socks5_proxy_conf=

if [[ "$HTTP_PROXY_HOST" && "$HTTP_PROXY_PORT" ]]; then
    http_proxy_conf="http $HTTP_PROXY_HOST $HTTP_PROXY_PORT $PROXY_USER $PROXY_PASSWORD"
fi

if [[ "$SOCKS5_PROXY_HOST" && "$SOCKS5_PROXY_PORT" ]]; then
    socks5_proxy_conf="socks5 $SOCKS5_PROXY_HOST $SOCKS5_PROXY_PORT $PROXY_USER $PROXY_PASSWORD"
fi

if [[ "$http_proxy_conf" || "$socks5_proxy_conf" ]]; then

    cat > /etc/proxychains/chatbot-proxy.conf << EOF
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
$http_proxy_conf
$socks5_proxy_conf
EOF

proxychains4 -f /etc/proxychains/chatbot-proxy.conf npm start &

else

npm start &

fi

wait $!
