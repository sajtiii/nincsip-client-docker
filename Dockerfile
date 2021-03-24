FROM alpine:latest

ARG SCHEDULE="*/15 * * * *"

RUN apk add --no-cache curl

RUN crontab -l | { cat; echo "$SCHEDULE curl -X POST -H \"Authorization: Bearer \${API_TOKEN}\" --fail \"https://api.nincsip.hu/v1/update-ip/\${DOMAIN}\" > /dev/stdout"; } | crontab -

CMD ["/usr/sbin/crond", "-f", "-l", "8"]
