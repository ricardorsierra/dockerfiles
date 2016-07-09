# VERSION:		0.1
# DESCRIPTION:	Create sublime-text 3 container with its dependencies (https://www.sublimetext.com/3)
# AUTHOR:		Christian Koep <christian.koep@fom-net.de>
# USAGE:
#	# Build sublime-text 3 image
#	docker build -t sublime-text:3 .
#
#	# Run the container and mount the local settings and your code
#	docker run -it \
#		-v $HOME/.config/sublime-text-3/:/root/.config/sublime-text-3 \
#		-v $HOME/development:/root/development \
#		-v /tmp/.X11-unix:/tmp/.X11-unix \
#		-e DISPLAY=$DISPLAY sublime-text:3
#
# POSSIBLE ISSUES:
#	# 'Gtk: cannot open display: :0'
#	Try to set 'DISPLAY=your_host_ip:0' or run 'xhost +' on your host.
#	(see: http://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0)
