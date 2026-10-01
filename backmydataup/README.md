# killerwolf/backmydataup

Archive a data volume from a container and mirror the archive to S3 (or any
S3-compatible store). Meant to be run as a one-shot job on a schedule, next to
the container whose `/data` you want to back up.

```console
docker run --rm \
  -v mydata:/data:ro \
  -v mybackups:/backup \
  -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY \
  -e S3_BUCKET=my-bucket \
  killerwolf/backmydataup:latest
```

## Configuration

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `S3_BUCKET` | yes | — | Destination bucket |
| `AWS_ACCESS_KEY_ID` | yes | — | Credentials |
| `AWS_SECRET_ACCESS_KEY` | yes | — | Credentials |
| `S3_ENDPOINT` | no | AWS S3 | S3-compatible endpoint, e.g. `https://s3.example.net` |
| `S3_PREFIX` | no | none | Key prefix inside the bucket |
| `DATA_DIR` | no | `/data` | Directory to archive |
| `BACKUP_DIR` | no | `/backup` | Local staging directory |
| `RETENTION_DAYS` | no | `0` (off) | Delete local archives older than N days |
| `BACKUP_TIMESTAMP` | no | UTC now | Override the archive timestamp |

Credentials can also come from an instance profile or `~/.aws`; do not hardcode
them in a compose file that lands in git.

## Behaviour

- Archives `DATA_DIR` to `BACKUP_DIR/data_<timestamp>.tar.gz` (`-C` is used so
  the archive extracts as `data/...`, without a leading-slash directory).
- Runs `aws s3 sync BACKUP_DIR s3://BUCKET/PREFIX`. `sync` is additive: it never
  deletes remote objects, so a prefix shared with other writers is safe.
- Retains archives locally by default. Set `RETENTION_DAYS` to prune.
- Remote retention is **not** handled here — configure a bucket lifecycle rule to
  expire old objects.
- Exits non-zero, with a message on stderr, if the bucket is unset, the data
  directory is missing, archiving fails, or the sync fails.

## S3-compatible stores

Set `S3_ENDPOINT`; the script forwards it as `--endpoint-url`.

```console
docker run --rm \
  -v mydata:/data:ro -v mybackups:/backup \
  -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY \
  -e S3_BUCKET=my-bucket -e S3_PREFIX=nightly \
  -e S3_ENDPOINT=https://s3.example.net \
  killerwolf/backmydataup:latest
```

## Scheduling

```yaml
services:
  backup:
    image: killerwolf/backmydataup:latest
    restart: unless-stopped
    environment:
      S3_BUCKET: my-bucket
      RETENTION_DAYS: "7"
    volumes:
      - mydata:/data:ro
      - mybackups:/backup
```

The image exits after one run, so pair it with a scheduler that restarts it, and
remember that host cron does not fire while the host is asleep.

## Notes

- Built on `amazon/aws-cli` pinned by digest (2.37.7, amd64 + arm64). AWS CLI v1
  entered maintenance mode in July 2026 and is unsupported from 15 July 2027;
  this image uses v2.
- The upstream image sets `ENTRYPOINT ["/usr/local/bin/aws"]`, which this
  Dockerfile resets — otherwise the script would be passed to `aws` as an
  argument instead of being executed.
