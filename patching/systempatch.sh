#!/bin/sh
#DISCLAIMER: if this script breaks your system, it is your fault you ran conde before checking the code, always check code which you dont own before running it!
#current release 20200301-1143
#GLOBAL SETTINGS
MYTIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
MYLOGFILE=/tmp/systempatch_scripted__"${MYTIMESTAMP}".log

#get distro

if [ -f hostnamectl ]; then
    MYDISTRO=$(hostnamectl | grep "Operating System:")
    MYDISTRO=${MYDISTRO:20}
    echo I am $MYDISTRO
else
    echo "no hostname hostnamectl found, will not run systemupdates"
fi

#UPDATE APPLIANCES
#update pihole if existing
if [ -f /usr/local/bin/pihole ]; then
    echo updating pihole appliance
    echo updating gravity
    pihole -g
    sleep 2s
    echo updating pihole
    pihole -up
    sleep 2s
    echo pihole done
fi

#UPDATES PIP SUFFS
#update pip if existing (pip2)
if [ -f /usr/local/bin/pip ]; then
    echo updating pip appliance
    echo updating pip
    pip install --upgrade pip
    sleep 2s
    echo updating outdated pip packages
    pip list --outdated | cut -f1 -d' ' | tr " " "\n" | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip install --upgrade
    sleep 2s
    echo  done
fi

#update pip3 if existing (Thanks to @Sagamir)
if [ -f /usr/bin/pip3 ]; then
    echo updating pip3 appliance
    echo updating pip3
    pip3 install --upgrade pip
    sleep 2s
    echo updating outdated pip3 packages
    pip3 list --outdated | cut -f1 -d' ' | tr " " "\n" | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip install --upgrade
    sleep 2s
fi


if [ ! -f hostnamectl ]; then
    echo exiting du to no hostnamectl
    #exit
fi
exit
#todo: add patching for different distros

#distro switcher




