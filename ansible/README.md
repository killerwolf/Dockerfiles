# killerwolf/ansible

> This container offers a containerized version of ansible. Avoid using localy instaled version of ansible

This container image is very lightweight < 50MB ans is based 

	killerbookpro:ansible killerwolf$ docker images
	REPOSITORY            TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
	killerwolf/ansible    latest              bcf71f52f6fa        23 hours ago        49.27 MB 

## Usage

	$ docker run --rm killerwolf/ansible ansible --version
	ansible 1.8.4
	  configured module search path = None

	$ docker run --rm killerwolf/ansible ansible-playbook --version
	ansible-playbook 1.8.4
	  configured module search path = None
