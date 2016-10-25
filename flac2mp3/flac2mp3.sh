#!/bin/bash

find /data -type f -name '*.flac' -exec bash -c 'avconv -y -i "$0" -qscale:a 0 "${0/%flac/mp3}" && rm -v "$0"' '{}' \;
