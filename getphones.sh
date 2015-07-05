#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

sudo rm -f phones-01.csv

sudo airodump-ng mon0 -w phones --output-format csv &

sleep 20

sudo kill $(ps aux | grep 'airodump-ng' | awk '{print $2}')

