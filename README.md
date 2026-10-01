# Dockerfiles

Custom Docker images that are worth maintaining. This used to hold ten images
from 2015-2016; most of them have been superseded by official or well-kept
images. What remains is the one image with no upstream equivalent.

## killerwolf/backmydataup

Archive a data volume from a container and sync the archive to S3 or any
S3-compatible store. Based on `amazon/aws-cli` v2, pinned by digest.

* **Documentation:** [backmydataup/README.md](backmydataup/README.md)
* **DockerHub:** [killerwolf/backmydataup](https://hub.docker.com/r/killerwolf/backmydataup)

```console
docker run --rm \
  -v mydata:/data:ro -v mybackups:/backup \
  -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY \
  -e S3_BUCKET=my-bucket \
  killerwolf/backmydataup:latest
```

## Removed images

These were dropped because an official or better-maintained image does the same
job. The history is intact if you need the old Dockerfiles.

| Image | Use instead |
| --- | --- |
| `ansible` | [`alpine/ansible`](https://hub.docker.com/r/alpine/ansible) or [`willhallonline/ansible`](https://hub.docker.com/r/willhallonline/ansible) |
| `nodejs` | [`node:alpine`](https://hub.docker.com/_/node) |
| `hugo` | [`klakegg/hugo`](https://hub.docker.com/r/klakegg/hugo) (referenced by Hugo's own docs) |
| `phptoolbelt` | `composer:2` / `php:8` official images |
| `nginx-php-imagick` | `php:8-fpm-alpine` + `apk add php-pecl-imagick`, `nginx:alpine` |
| `people-front-app` | project-specific; build it in the app's own repo |
| `data` | `alpine` or `busybox` directly |
| `h2o` | never built — no upstream project of that name is maintained here |
| `weed` | [`chrislusf/seaweedfs`](https://hub.docker.com/r/chrislusf/seaweedfs) |

## Maintenance

CI lives in `.github/workflows/ci.yml`: hadolint, shellcheck, a build of both
architectures, a smoke test that checks the container refuses to run without
`S3_BUCKET`, a Trivy scan, and a digest-drift check that warns when the pinned
base image moves. Releases are pushed to Docker Hub from `master`.

Images on Docker Hub are only rebuilt when a push to `master` lands. There is no
scheduled rebuild, so tags follow this repository rather than upstream.

## Contributing

Keep an image here only if no maintained image covers the need, and expect CI to
enforce it. Fork and send a pull request.
