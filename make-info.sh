#!/bin/bash
#==========================================================================
#        FILE: make-info.sh
#
# DESCRIPTION: Display Android device informations
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.1.1
#     CREATED: 10.04.2019
#==========================================================================

#==========================================================================
# Copyright 2019, 2020, 2021 Mihai Gătejescu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#==========================================================================

if [ $(adb devices | wc -l) == 2 ]; then
    echo "No devices connectetd"
    echo
    exit 1
elif [ "$(adb devices | grep -e 'unauthorized')" ]; then
    echo "Device unauthorized"
    echo
    exit 1
else
    # Check if we are on MacOS
    #   then we use GNU sed
    #   if it is not installed,
    #   ask the user to install it
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [ -z $(command -v gsed) ]; then
            echo "Please install GNU sed."
            exit 1
        fi
        op_sed=gsed

    else
        op_sed=sed
    fi

    # Get device id
    deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' |
            $op_sed -r '/^\s*$/d')

    # Get information
    dev_properties=$(adb -s "$deviceid" shell getprop)
    manufacturer=$(echo "$dev_properties" |
            grep -e "ro.product.manufacturer" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    model=$(echo "$dev_properties" | grep -e "ro.product.model" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    firmware=$(echo "$dev_properties" | grep -e "ro.build.version.release" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    cpu=$(echo "$dev_properties" | grep -e "ro.product.cpu.abi]" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    if [ -z "$cpu" ]; then
        cpu=$(adb shell cat /proc/cpuinfo | grep -e "model name" |
            cut -f2 -d':' | uniq)
    fi
    debugging=$(echo "$dev_properties" | grep -e "init.svc.adbd" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    wifi=$(adb shell dumpsys netstats | grep -E 'iface=wlan.*networkId'|
            cut -f2 -d"\"" | uniq)
    language=$(echo "$dev_properties"|
            grep -e "ro.product.locale.language" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    region=$(echo "$dev_properties" | grep -e "ro.product.locale.region" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    timezone=$(echo "$dev_properties" | grep -e "persist.sys.timezone" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')
    date=$(adb -s "$deviceid" shell date +%d/%m/%Y)
    time=$(adb -s "$deviceid" shell date +%T)
    sim=$(echo "$dev_properties" | grep -e "gsm.sim.state" |
            cut -f2 -d' ' | $op_sed 's/\[//' | $op_sed 's/\]//')

    # Display information
    echo ""
    echo "//=========================================================="
    echo "//"
    echo "//     manufacturer...$manufacturer"
    echo "//     model..........$model"
    echo "//     firmware.......$firmware"
    if [ -z "$cpu" ]; then
        cpu="N/A"
    fi
    echo "//     cpu............$cpu"
    echo "//"
    echo "//     debugging......$debugging"
    if [ -z "$wifi" ]; then
        wifi="NO"
    fi
    echo "//     wifi...........$wifi"
    if [ -z "$region" ]; then
        region="N/A"
    fi
    echo "//     region.........$region"
    if [ -z "$language" ]; then
        language="N/A"
    fi
    echo "//     language.......$language"
    echo "//     timezone.......$timezone"
    echo "//     date...........$date"
    echo "//     time...........$time"
    if [ -z "$sim" ]; then
        sim="NO"
    fi
    echo "//     sim............$sim"
    echo "//"
    echo "//=========================================================="
    echo ""
fi

# TODO
#   Most of the times the region and languge are empty
#   Concat region and language (e.g. US_en)
#   Make it work for multiple devices
