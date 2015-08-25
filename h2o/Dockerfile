FROM alpine:3.2

MAINTAINER killerwolf <killerwolf06@gmail.com> @killerwolf

RUN apk --update add cmake openssl gcc libc-dev libuv build-base && \
	rm -rf /var/cache/apk/*

EXPOSE 8080