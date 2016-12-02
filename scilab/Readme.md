 VERSION:		  0.1
 DESCRIPTION:	  Create the scilab in a container
 AUTHOR:		  Ricardo Rebello Sierra <contato@ricardosierra.com.br>
 COMMENTS:
	This file describes how to build the scilab
	in a container with all dependencies installed.
 USAGE:
	# Download scilab Dockerfile
	wget http://raw.githubusercontent.com/ricardorsierra/dockerfiles/master/scilab/5.5/Dockerfile

	# Build scilab image
	docker build -t scilab .

	docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY scilab

  # Bash Function
  scilab(){
  	echo "Running scilab with docker..."
  	docker run --rm -it \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		sierratecnologia/scilab "$@"
  }
