#!/bin/sh

tar czvf /backup/data_`date +%Y%m%d_%H%M%S`.tar /data
aws s3 sync /backup s3://$S3_BUCKET --endpoint-url=http://fr-1.storage.online.net
