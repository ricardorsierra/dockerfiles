 VERSION:		  0.1
 DESCRIPTION:	  Create the teamviewer in a container
 AUTHOR:		  Ricardo Rebello Sierra <contato@ricardosierra.com.br>
 COMMENTS:
	This file describes how to build the teamviewer
	in a container with all dependencies installed.
 USAGE:
	# Download teamviewer Dockerfile
	wget http://raw.githubusercontent.com/ricardorsierra/dockerfiles/master/teamviewer/12/Dockerfile

	# Build teamviewer image
	docker build -t teamviewer .

	docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY teamviewer

  # Bash Function
  teamviewer(){
  	echo "Running teamviewer with docker..."
  	docker run --rm -it \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		sierratecnologia/teamviewer "$@"
  }
