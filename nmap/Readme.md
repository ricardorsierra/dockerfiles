# VERSION:		  0.1
# DESCRIPTION:	  Create the nmap in a container
# AUTHOR:		  Ricardo Rebello Sierra <contato@ricardosierra.com.br>
# COMMENTS:
#	This file describes how to build the nmap
#	in a container with all dependencies installed.
# USAGE:
#	# Download nmap Dockerfile
#	wget http://raw.githubusercontent.com/ricardorsierra/dockerfiles/master/nmap/Dockerfile
#
#	# Build nmap image
#	docker build -t nmap .
#
#	docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
#		-e DISPLAY=unix$DISPLAY nmap
#
#  # Bash Function
#  nmap(){
#  	echo "Running Nmap with docker..."
#  	docker run --rm -it \
#  		--net host \
#  		sierratecnologia/nmap "$@"
#  }

