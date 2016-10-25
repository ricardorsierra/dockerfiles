#!/bin/bash
for i in * ; do HandBrakeCLI -i "$i" -o "$i".mp4 --preset="iPad" ; done
