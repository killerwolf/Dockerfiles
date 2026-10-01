#!/bin/sh
#
# Archive a data volume and mirror it to S3 (or any S3-compatible store).
#
# Required environment:
#   S3_BUCKET                     destination bucket
#   AWS_ACCESS_KEY_ID /
#   AWS_SECRET_ACCESS_KEY         credentials
#
# Optional environment:
#   S3_ENDPOINT        S3-compatible endpoint (e.g. https://s3.example.net).
#                      Leave unset to target real AWS S3.
#   S3_PREFIX          key prefix inside the bucket (default: none)
#   DATA_DIR           source directory to archive (default: /data)
#   BACKUP_DIR         local staging directory (default: /backup)
#   RETENTION_DAYS     delete local archives older than N days; 0 disables
#                      local pruning (default: 0)
#   BACKUP_TIMESTAMP   archive timestamp, injectable for idempotency/testing

set -eu

DATA_DIR="${DATA_DIR:-/data}"
BACKUP_DIR="${BACKUP_DIR:-/backup}"
S3_PREFIX="${S3_PREFIX:-}"
RETENTION_DAYS="${RETENTION_DAYS:-0}"
BACKUP_TIMESTAMP="${BACKUP_TIMESTAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"

die() {
    echo "backmydataup: $*" >&2
    exit 1
}

[ -n "${S3_BUCKET:-}" ] || die "S3_BUCKET is not set"
[ -d "$DATA_DIR" ] || die "data directory '$DATA_DIR' does not exist"

mkdir -p "$BACKUP_DIR"

ARCHIVE="$BACKUP_DIR/data_${BACKUP_TIMESTAMP}.tar.gz"

# -C strips the leading slash so the archive extracts as 'data/...'.
echo "backmydataup: archiving $DATA_DIR -> $ARCHIVE"
tar czf "$ARCHIVE" -C "$(dirname "$DATA_DIR")" "$(basename "$DATA_DIR")" \
    || die "archive of '$DATA_DIR' failed"

if [ "${RETENTION_DAYS}" -gt 0 ] 2>/dev/null; then
    echo "backmydataup: pruning local archives older than ${RETENTION_DAYS}d"
    find "$BACKUP_DIR" -maxdepth 1 -name 'data_*.tar.gz' -type f \
        -mtime "+${RETENTION_DAYS}" -print -delete
fi

DEST="s3://${S3_BUCKET}"
[ -n "$S3_PREFIX" ] && DEST="${DEST}/${S3_PREFIX#/}"

if [ -n "${S3_ENDPOINT:-}" ]; then
    echo "backmydataup: syncing $BACKUP_DIR -> ${DEST} (${S3_ENDPOINT})"
    # sync is additive and never deletes remote objects, so a prefix shared with
    # other writers stays safe. Bucket lifecycle rules reclaim old archives.
    aws s3 sync "$BACKUP_DIR" "$DEST" --endpoint-url "$S3_ENDPOINT" \
        || die "s3 sync to '${DEST}' failed"
else
    echo "backmydataup: syncing $BACKUP_DIR -> ${DEST}"
    aws s3 sync "$BACKUP_DIR" "$DEST" \
        || die "s3 sync to '${DEST}' failed"
fi

echo "backmydataup: done"
