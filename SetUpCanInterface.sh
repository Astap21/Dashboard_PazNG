#!/bin/sh
run "ip link set can0 up type can bitrate 250000"

#/sbin/ifconfig can0 up
#until [ifconfig | grep -q "can"]
#do
#sleep 1
#/sbin/ifconfig can0 up
#done
