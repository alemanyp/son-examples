#!/bin/bash

# remove IPs from input/output interface to prepare them for bridging
ip addr flush dev $IFIN
ip addr flush dev $IFOUT

# bridge interfaces (layer 2) and let snort listen to bridge (IDS mode)
brctl addbr br0
brctl addif br0 $IFIN $IFOUT
ifconfig br0 up

sleep 1

# run snort as background process
snort -i br0 -D -q -k none -K ascii -l /snort-logs -A fast -c /etc/snort/snort.conf

echo "Snort VNF started ..."

