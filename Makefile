# vim:ft=make:

.PHONY : all

all: build

build:
	docker build -t mpepping/cyberchef:latest .

clean:
	docker rmi mpepping/cyberchef:latest
