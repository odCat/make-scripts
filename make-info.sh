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

deviceid=$(adb devices | grep -v -e "List" | cut -f1 -d$'\t' |
           sed -r '/^\s*$/d')

adb -s "$deviceid" shell getprop

# TODO
# Choose what information to display
#          [init.svc.adbd]: [running]
#          [persist.sys.usb.config]: [mtp,adb]
#          [ril.product_code]: [SM-N950UZVAXAA]
#          [ro.build.version.release]: [8.0.0]
#          [ro.build.version.security_patch]: [2018-08-01]
#          [ro.com.google.gmsversion]: [8.0_201805]
#          [ro.build.version.base_os]: [samsung/greatqlteue/greatqlteue:8.0.0/R16NW/N950U1UEU5CRG6:user/release-keys]
# Implement how the information is gathered and shown
# Check OS X compatibility
#          sed '/^[[:space:]]*$/d'
#          OR
#          sed -i "" '/^[[:space:]]*$/d'
