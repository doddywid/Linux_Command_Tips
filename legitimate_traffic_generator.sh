#!/bin/bash

# URL of the website you want to access
URL="https://arcadia.example.com/"

generate_public_ip() {
local ip
while true; do
	ip=$(printf "%d.%d.%d.%d" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
	#echo $ip
	if ! [[ $ip =~ ^(10|172\.(1[6-9]|2[0-9]|3[0-1])|192\.168)\. ]]; then
		echo $ip
		return
	fi
done
}

while true; do
for i in {1..5}; do
	xff_ip=$(generate_public_ip)
	curl -s -H "xff: $xff_ip" $URL > /dev/null
	#echo "Accessed $URL with IP $xff_ip: attempt $i"
done
sleep 30
done
