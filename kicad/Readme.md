 VERSION:		  0.1
 DESCRIPTION:	  Create the kicad in a container
 AUTHOR:		  Ricardo Rebello Sierra <contato@ricardosierra.com.br>
 COMMENTS:
	This file describes how to build the kicad
	in a container with all dependencies installed.
 USAGE:
	# Download kicad Dockerfile
	wget http://raw.githubusercontent.com/ricardorsierra/dockerfiles/master/kicad/4.0/Dockerfile

	# Build kicad image
	docker build -t kicad .

	docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY kicad

  # Bash Function
  kicad(){
  	echo "Running kicad with docker..."
  	docker run --rm -it \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		sierratecnologia/kicad "$@"
  }
