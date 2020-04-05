#!/bin/bash 
now=$(date +"%Y-%m-%d_%T")
file="services-$1-$now.txt"

ports=$(nmap -p- --min-rate=1000 -T4 $1 | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)

echo "Scanning started"

nmap -sC -sV -p$ports $1 > $file

echo "Scan completed"

echo "Displaying services found"

cat $file
