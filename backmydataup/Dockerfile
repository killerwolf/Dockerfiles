FROM alpine:latest

MAINTAINER killerwolf <killerwolf06@gmail.com> @killerwolf

#dedicated backup volume
VOLUME /backup

# create backup file
CMD ["tar","czvf","/backup/data_`date +%Y%m%d_%H%M%S`.tar","/data"]