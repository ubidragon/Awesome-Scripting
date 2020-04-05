#!/bin/bash

#Idea of this script thanks S4vitar
#https://pastebin.com/yGvk0Ve8

#terminal colour
#https://robologs.net/2016/03/31/como-colorear-el-output-de-la-terminal-en-linux/

OUTPUT=""
INTERFAZ=""

for interfaz in $(ip a | grep "mtu " | awk '{print $2}' )
do
	INTERFAZ=$(echo $interfaz | sed 's/://')
	if [ "$INTERFAZ" != "lo" ];	
	then
	    for ips in $(ip address show $INTERFAZ | grep "inet " | awk '{print $2}')
	    do
		OUTPUT+="\e[32m$interfaz\e[0m"
		OUTPUT+=" \t"
		OUTPUT+=$ips
		OUTPUT+="\n"
	    done
	fi
done

GATEWAY=$(ip r | grep "default" | awk '{print $3}')

#printf "$OUTPUT " '%s\n' "$GATEWAY"
OUTPUT+="Gateway:\t" 
OUTPUT+=$GATEWAY
shopt -s xpg_echo

echo $OUTPUT

