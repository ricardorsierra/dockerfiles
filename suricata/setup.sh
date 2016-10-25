#!/bin/bash
IFACE=${IFACE:-eth0}
for i in rx tx sg tso ufo gso gro lro; do ethtool -K $IFACE $i off; done

suricata -c suricata.yaml -i $IFACE
