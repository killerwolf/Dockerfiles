# killerwolf/hugo

[![](https://badge.imagelayers.io/killerwolf/hugo:latest.svg)](https://imagelayers.io/?images=killerwolf/hugo:latest 'Get your own badge on imagelayers.io') [![Circle CI](https://circleci.com/gh/killerwolf/docker-hugo/tree/master.svg?style=svg)](https://circleci.com/gh/killerwolf/docker-hugo/tree/master)

This repository powers [killerwolf/hugo](https://registry.hub.docker.com/u/killerwolf/hugo/) docker image built for several versions of [hugo](http://gohugo.io), a markdown backed blog engine written in [golang](https://golang.org)

```console
$ docker run killerwolf/hugo:0.13 version
Hugo Static Site Generator v0.13 BuildDate: 2015-02-22T04:02:30Z

## Usage 

### Create a new site

Let's run our first command: bootstraping a new blog with hugo:

```console
$ mkdir ~/blog && cd blog
$ docker run --rm -v $PWD:/blog:rw killerwolf/hugo new site /blog
```

This command generate a new skeleton (files and folder)

```console
$ ls
archetypes	config.toml	content		data		layouts		static
```

### Choose your theme

Adding our chosen theme (herring-cove, you're free to swap it)

```console
$ mkdir themes && cd themes
$ git clone https://github.com/spf13/herring-cove.git
```

### Generate static blog

Write some markdown content into `content/` directory, and then launch 

```console
$ docker run --rm -v $PWD:/app:rw killerwolf/hugo -s /app -d dist/
```

You'll find fond your generated blog under the `dist` folder

## Contributing

Fork and send a pull request