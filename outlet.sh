#!/bin/bash

gpio mode 7 out
gpio write 7 1
sleep 0.5
gpio write 7 0
sleep 0.5

