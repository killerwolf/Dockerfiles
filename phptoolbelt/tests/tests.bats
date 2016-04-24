#!/usr/bin/env bats

@test "Test phing version is 2.14.0" {
	docker run killerwolf/phptoolbelt phing -version | grep "2.14.0"
}

@test "Test composer version is 1.0.2" {
	docker run killerwolf/phptoolbelt composer --version | grep " 1.0.2 "
}

@test "Test composer install works (vendor/ and composer.lock presents)" {
	docker run -v $(pwd)/phptoolbelt/tests/fixtures:/app killerwolf/phptoolbelt composer install && [ -d $(pwd)/phptoolbelt/tests/fixtures/vendor/composer ] && [ -f $(pwd)/phptoolbelt/tests/fixtures/composer.lock ]
}

@test "Test composer install works with phing" {
	rm -rf $(pwd)/phptoolbelt/tests/fixtures/{composer.lock,vendor/}
	docker run -v $(pwd)/phptoolbelt/tests/fixtures:/app killerwolf/phptoolbelt phing composer_install && [ -d $(pwd)/phptoolbelt/tests/fixtures/vendor/composer ] && [ -f $(pwd)/phptoolbelt/tests/fixtures/composer.lock ]
}

@test "Test phpunit version is 5.3.2" {
	docker run killerwolf/phptoolbelt phpunit --version | grep " 5.3.2 "
}

@test "Test phpunit testing " {
	docker run -v $(pwd)/phptoolbelt/tests/fixtures:/app killerwolf/phptoolbelt phpunit --bootstrap vendor/autoload.php tests
}

@test "Test phpunit testing with phing" {
	docker run -v $(pwd)/phptoolbelt/tests/fixtures:/app killerwolf/phptoolbelt phing test
}

@test "Test phing app building (composer install and phpunit tests)" {
}