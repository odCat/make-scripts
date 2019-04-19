#!/bin/bash
#==========================================================================
#        FILE: make-info.sh
#
# DESCRIPTION: Display Android device informations
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.0.0
#     CREATED: 10.04.2019
#==========================================================================

#==========================================================================
# Copyright 2019 Mihai Gătejescu
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
else
    # Get device id
    if [ "$OSTYPE" == "darwin"* ]; then
        deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' |
                   tr "\n" -d | sed 's/--//')
    else
        deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' |
                   sed -r '/^\s*$/d')
    fi

    # Get information
    dev_properties=$(adb -s "$deviceid" shell getprop)
    manufacturer=$(echo "$dev_properties" |
            grep -e "ro.product.manufacturer" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    model=$(echo "$dev_properties" | grep -e "ro.product.model" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    firmware=$(echo "$dev_properties" | grep -e "ro.build.version.release" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    debugging=$(echo "$dev_properties" | grep -e "init.svc.adbd" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    wifi=$(adb shell dumpsys netstats | grep -E 'iface=wlan.*networkId'|
            cut -f2 -d"\"" | uniq)
    language=$(echo "$dev_properties"|
            grep -e "ro.product.locale.language" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')

    region=$(echo "$dev_properties" | grep -e "ro.product.locale.region" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    timezone=$(echo "$dev_properties" | grep -e "persist.sys.timezone" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')
    date=$(adb -s "$deviceid" shell date)
    sim=$(echo "$dev_properties" | grep -e "gsm.sim.state" |
            cut -f2 -d' ' | sed 's/\[//' | sed 's/\]//')

    # Display information
    echo ""
    echo "//=========================================================="
    echo "//"
    echo "//     manufacturer...$manufacturer"
    echo "//     model..........$model"
    echo "//     firmware.......$firmware"
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
    if [ -z "$sim" ]; then
        sim="NO"
    fi
    echo "//     sim............$sim"
    echo "//"
    echo "//=========================================================="
    echo ""
fi

# TODO
# Test on MacOS
#   change to gsed on MacOC
# Concat region and language (e.g. US_en)
# Format date
# Add CPU info
#   adb shell cat /proc/cpuinfo
#   adb shell getprop | grep abi
