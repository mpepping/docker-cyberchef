# vim:ft=make:

.PHONY : all

all: build

build:
	docker build -t mpepping/cyberchef:latest .

clean:
	docker rmi mpepping/cyberchef:latest

start:
	docker run -d --rm -p 8000:8000 --name cyberchef mpepping/cyberchef:latest

stop:
	docker rm -f cyberchef

