FROM alpine:3.2

ENV GOPATH /go

RUN apk --update add go git mercurial && \
	rm -rf /var/cache/apk/* &&  \
	go get -v github.com/spf13/hugo

ENTRYPOINT ["./go/bin/hugo"]

#RUN apk --update add curl tar && \
#	rm -rf /var/cache/apk/*
#RUN curl -L https://github.com/spf13/hugo/releases/download/v0.14/hugo_0.14_linux_amd64.tar.gz | tar xvz
#ENTRYPOINT ["./hugo_0.14_linux_amd64/hugo_0.14_linux_amd64"]