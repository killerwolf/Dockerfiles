# killerwolf/ansible

[![](https://badge.imagelayers.io/killerwolf/ansible:latest.svg)](https://imagelayers.io/?images=killerwolf/ansible:latest 'Get your own badge on imagelayers.io')

> This container offers a containerized version of ansible. Avoid using localy instaled version of ansible

This container image is very lightweight =~ 50MB ans is based 

```console
$ docker images
REPOSITORY                TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
killerwolf/ansible        latest              1211b02a960d        7 minutes ago       56.57 MB
killerwolf/ansible        1.9.2               1211b02a960d        7 minutes ago       56.57 MB
killerwolf/ansible        1.8.4               77df4c1ec794        7 minutes ago       49.27 MB
killerwolf/ansible        1.8.2               219db314f656        7 minutes ago       49.24 MB
killerwolf/ansible        1.6.7               8d1dda0ccbf6        7 minutes ago       51.28 MB
```

## Usage

```console
$ docker run --rm killerwolf/ansible:1.8.4 ansible --version
ansible 1.8.4
  configured module search path = None
```

```console
$ docker run --rm killerwolf/ansible:1.8.4 ansible-playbook --version
ansible-playbook 1.8.4
  configured module search path = None
```