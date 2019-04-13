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
    if [[ "$OSTYPE" == "darwin"* ]]; then
        deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' | tr "\n" -d |
                   sed 's/--//')
    else
        deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' |
                   sed -r '/^\s*$/d')
    fi

    adb -s "$deviceid" shell getprop
fi

# TODO
# Choose what information to display
#          [net.bt.name]: [Android]
#          [ro.product.locale.language]: [en]
#          [ro.product.locale.region]: [US]
#          [ro.product.manufacturer]: [asus]
#          [ro.product.model]: [ASUS_X014D]
#          [persist.sys.timezone]: [Europe/Bucharest]
#          [ro.build.date]: [Thu Jun 22 09:27:23 CST 2017]
#          [ro.wifi.channels]: []
#          [init.svc.adbd]: [running]
#          [persist.sys.usb.config]: [mtp,adb]
#          [ro.build.version.release]: [8.0.0]
#         [gsm.sim.state] 
# Implement how the information is gathered and shown

