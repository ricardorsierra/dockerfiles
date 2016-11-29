 VERSION:		  0.1
 DESCRIPTION:	  Create the maltego in a container
 AUTHOR:		  Ricardo Rebello Sierra <contato@ricardosierra.com.br>
 COMMENTS:
	This file describes how to build the maltego
	in a container with all dependencies installed.
 USAGE:
	# Download maltego Dockerfile
	wget http://raw.githubusercontent.com/ricardorsierra/dockerfiles/master/maltego/Dockerfile

	# Build maltego image
	docker build -t maltego .

	docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY maltego

  # Bash Function
  maltego(){
  	echo "Running maltego with docker..."
  	docker run --rm -it \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		sierratecnologia/maltego "$@"
  }
