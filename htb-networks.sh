#!/bin/bash

#Idea of this script thanks S4vitar
#https://pastebin.com/yGvk0Ve8

#terminal colour
#https://robologs.net/2016/03/31/como-colorear-el-output-de-la-terminal-en-linux/

OUTPUT=""
INTERFAZ=""
SEPARADOR="\t|\t"

for interfaz in $(ip a | grep "mtu " | awk '{print $2}' )
do
	INTERFAZ=$(echo $interfaz | sed 's/://')
	
	if [ "$INTERFAZ" != "lo" ];	
	then
	    for ips in $(ip address show $INTERFAZ | grep "inet " | awk '{print $2}')
	    do
		#coloreado de verde
		#OUTPUT+="\e[32m$interfaz\e[0m"
		if [ "$INTERFAZ" == "tun0" ];
		then
			OUTPUT+="HTB:"
		else
			OUTPUT+=$interfaz
		fi
		
		OUTPUT+="\t"
		OUTPUT+=$ips
		OUTPUT+=$SEPARADOR
	    done
		
	    EXIST=$(ip r | grep 'default' | grep $INTERFAZ | awk '{print $3}')

	    if [ ! -z "$EXIST" ];
	    then
		
		if [ "$INTERFAZ" == "tun0" ];
		then
			GATEWAY+="Gateway HTB:\t"
		else
			GATEWAY+="Gateway:\t" 
		fi
		   
		   GATEWAY+=$EXIST
		   GATEWAY+=$SEPARADOR
	    fi    
	fi
done

#printf "$OUTPUT " '%s\n' "$GATEWAY"
#OUTPUT+="Gateway:\t" 
OUTPUT+=$GATEWAY
shopt -s xpg_echo

echo $OUTPUT

