# vim:ft=make:

.PHONY : all

all: build

build:
	docker build -t cyberchef:master .

clean:
	docker rmi cyberchef:master
