TAG_NAME=nhnghia/terminalizer
all:
	docker rmi ${TAG_NAME} || true
	docker build --tag ${TAG_NAME} .
	docker image ls
