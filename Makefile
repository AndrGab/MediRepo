build:
	docker build -t medirepo --ssh default --target build --build-arg MIX_ENV=dev  .