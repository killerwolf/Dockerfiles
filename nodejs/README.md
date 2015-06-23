# NodeJS Docker image

This images provide `nodejs` execution environement. the following image is based on `alpine` linux docker image. The virtual size of the image is `21.82 MB` whereas the official image is way heavier.

    docker run killerwolf/node node -v 
    v0.12.2

Example:

    $ git clone git@github.com:shapeshed/express_example.git express_example && cd express_example
    $ docker run -d -p 8080:8080 -v "$PWD":/app -w /app -e PORT=8080   killerwolf/node npm install && node server.js

You're all set, browse to `http://localhost:8080`
![Express Example](http://shapeshed.com/images/articles/express_example.jpg)