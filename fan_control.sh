#!/bin/bash

#NOTE: IPMItools must be installed in host OS

##################################
#enable manual fna control
ipmitool raw 0x30 0x30 0x01 0x00

#NOTE: to disable manual fan control
#ipmitool raw 0x30 0x30 0x01 0x01
##################################

echo "Reading CPU temperatures for the fan speed adjustment..."
ipmitool sdr list | grep Temp > temp.txt

#read cpu 1 temp
t1=`tail -n2 temp.txt | head -1 | sed 's/degree.*//' | cut -d "|" -f2 | sed -e 's/^[[:space:]]*//'`
#read cpu 2 temp
t2=`tail -n1 temp.txt | sed 's/degree.*//' | cut -d "|" -f2 | sed -e 's/^[[:space:]]*//'`

#remove old files
rm -rf temp.txt

#note down higher temperature
t3=$((t1>t2 ? t1 : t2))

echo 'Current temperature of the hottest CPU is =' $t3

#for temp greater than 45
if [ $t3 -gt 45 ]
then
    echo "Setting fan speed to 36%..."
    #set fan speed to 0x24(36%)
    #NOTE: when same command is run from different machine then command is different
    #from different machine = ipmitool -I lanplus -H <IPMI IP> -U <User ID> -P <password> raw 0x30 0x30 0x02 0xff 0x24
    ipmitool raw 0x30 0x30 0x02 0xff 0x24

elif [ $t3 -gt 44 ]
then
    echo "Setting fan speed to 34%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x22

elif [ $t3 -gt 43 ]
then
    echo "Setting fan speed to 32%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x20

elif [ $t3 -gt 42 ]
then
    echo "Setting fan speed to 30%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x1e

elif [ $t3 -gt 41 ]
then
    echo "Setting fan speed to 28%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x1c

elif [ $t3 -gt 40 ]
then
    echo "Setting fan speed to 26%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x1a

elif [ $t3 -gt 39 ]
then
    echo "Setting fan speed to 24%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x18

elif [ $t3 -gt 38 ]
then
    echo "Setting fan speed to 22%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x16

elif [ $t3 -gt 37 ]
then
    echo "Setting fan speed to 20%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x14

elif [ $t3 -gt 36 ]
then
    echo "Setting fan speed to 18%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x12

elif [ $t3 -gt 35 ]
then
    echo "Setting fan speed to 16%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x10

elif [ $t3 -gt 34 ]
then
    echo "Setting fan speed to 14%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x0e

elif [ $t3 -gt 33 ]
then
    echo "Setting fan speed to 12%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x0c

elif [ $t3 -gt 32 ]
then
    echo "Setting fan speed to 10%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x0a

else
    echo "Setting fan speed to 8%..."
    ipmitool raw 0x30 0x30 0x02 0xff 0x08

fi
