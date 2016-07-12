# docker-clementine

Clementine in a Docker container

## Requirements

* Docker 1.2+ (should work fine on 1.0+ but I haven't tried)
* An X11 socket

## Usage

docker run -it \
		-v $HOME/.config/clementine/:/root/.config/clementine \
		-v $HOME/Musicas:/root/Music \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$DISPLAY clementine
