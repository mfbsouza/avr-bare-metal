#!/bin/bash

# defaults

port='/dev/ttyACM0'
mcu='atmega328p'
programmer='arduino'
hexfile='build/release/firmware.hex'


while getopts P:m:c:b: flag
do
    case "${flag}" in
        P) port=${OPTARG};;
        m) mcu=${OPTARG};;
        c) programmer=${OPTARG};;
        b) hexfile=${OPTARG};;
    esac
done

avrdude -v -p $mcu -c $programmer -P $port -U flash:w:$hexfile
