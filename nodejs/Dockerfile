FROM alpine:3.1

RUN apk --update add nodejs && \
	rm -rf /var/cache/apk/*

EXPOSE 8080
ENTRYPOINT ["npm","install","&&","npm","start"]