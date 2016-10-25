#!/bin/bash
set -x
htpasswd -b -c /etc/htpasswd $USER $PASSWORD

nginx
