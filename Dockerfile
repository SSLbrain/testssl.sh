FROM alpine:3.17

RUN apk update && \
    apk upgrade && \
    apk add bash procps drill git coreutils libidn curl socat openssl xxd && \
    rm -rf /var/cache/apk/* && \
    addgroup testssl && \
    adduser -G testssl -g "testssl user" -s /bin/bash -D testssl && \
    ln -s /home/testssl/testssl.sh /usr/local/bin/

USER testssl
WORKDIR /home/testssl/

COPY --chown=testssl:testssl etc/. /home/testssl/etc/
COPY --chown=testssl:testssl bin/. /home/testssl/bin/
COPY --chown=testssl:testssl testssl.sh /home/testssl/

ENTRYPOINT ["testssl.sh"]

CMD ["--help"]
