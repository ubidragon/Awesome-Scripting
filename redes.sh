#!/bin/bash

#Idea de este script a S4vitar
#https://pastebin.com/yGvk0Ve8

#Color de terminal
#https://robologs.net/2016/03/31/como-colorear-el-output-de-la-terminal-en-linux/

OUTPUT=""
INTERFAZ=""

for interfaz in $(ip a | grep "mtu " | awk '{print $2}' )
do
	INTERFAZ=$(echo $interfaz | sed 's/://')
	
    for ips in $(ip address show $INTERFAZ | grep "inet " | awk '{print $2}')
    do
        OUTPUT+="\e[32m$interfaz\e[0m"
        OUTPUT+=" \t"
        OUTPUT+=$ips
        OUTPUT+="\n"
    done
    
done

GATEWAY=$(ip r | grep "default" | awk '{print $3}')

#printf "$OUTPUT " '%s\n' "$GATEWAY"
OUTPUT+="\nGateway:\t" 
OUTPUT+=$GATEWAY
shopt -s xpg_echo

echo $OUTPUT

