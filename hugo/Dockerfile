FROM alpine:3.2

ENV GOPATH $HOME/go

RUN apk --update go git mercurial && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["./root/go/bin/hugo"]