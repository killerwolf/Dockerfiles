#!/usr/bin/env bats

@test "Test composer version is 1.0.2" {
	docker run killerwolf/phptoolbelt composer --version | grep " 1.0.2 "
}

@test "Test phing version is 2.14.0" {
	docker run killerwolf/phptoolbelt phing -version | grep "2.14.0"
}

@test "Test phpunit version is 5.3.2" {
	docker run killerwolf/phptoolbelt phpunit --version | grep " 5.3.2 "
}