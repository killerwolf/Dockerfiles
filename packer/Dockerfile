FROM alpine:edge

MAINTAINER Hamdi LAADHARI @killerwolf

ENV PACKER_VERSION 0.8.5

RUN apk --update add wget unzip && \
	wget --no-check-certificate https://dl.bintray.com/mitchellh/packer/packer_$PACKER_VERSION_linux_amd64.zip && \
	unzip -d /usr/local/bin packer__linux_amd64.zip && \
	apk del --purge -r wget unzip && \
	rm -fr packer_$PACKER_VERSION_linux_amd64.zip && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["packer"]
