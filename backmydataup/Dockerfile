# syntax=docker/dockerfile:1
#
# Pinned by digest so the base cannot change under us: AWS CLI releases often
# rebuild the same tag with a newer AL2023 layer set.
#   amd64 + arm64 (verified against the manifest list on 2026-10-01)
ARG AWS_CLI_VERSION=2.37.7
FROM amazon/aws-cli:${AWS_CLI_VERSION}@sha256:95f8d1e6d31aaa16997d1406eb532b0ca6a9830fe8a859c37a0fd223f10959e5

LABEL org.opencontainers.image.title="backmydataup" \
      org.opencontainers.image.description="Archive a data volume and sync it to S3 or any S3-compatible store" \
      org.opencontainers.image.source="https://github.com/killerwolf/Dockerfiles" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="1.0.0"

# The upstream image hard-sets ENTRYPOINT ["/usr/local/bin/aws"], which would
# swallow our script as an argument to `aws`. Reset it so the script runs.
ENTRYPOINT ["/backmydataup.sh"]

VOLUME ["/data", "/backup"]

# The base image is a minimal aws-cli layer set: it ships coreutils, findutils
# and sed, but neither tar nor gzip, so backmydataup.sh cannot archive anything
# until they are installed. gzip arrives as a tar dependency.
# Version is deliberately unpinned (DL3041): the base is already pinned by
# digest, and AL2023's tar version moves with repository updates, so pinning
# it here would mostly turn routine security updates into build failures.
RUN dnf install -y tar && dnf clean all # hadolint ignore=DL3041

COPY backmydataup.sh /backmydataup.sh
RUN chmod 0755 /backmydataup.sh
