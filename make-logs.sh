#!/bin/bash
#==========================================================================
#        FILE: make_logs.sh
#
# DESCRIPTION: Pipes the output of the adb logcat command to the tee 
#              command to write to stdout and to write logfiles
#              Creates a directory tree: year/month/daylogfile.
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.1.0
#     CREATED: 05.09.2017
#==========================================================================

#==========================================================================
# Copyright 2017 Mihai Gătejescu
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

# Define show_usage() function
show_usage()
{
	echo "Usage: $0 \"adb logcat filter option\"" 1>&2
	exit 1
}

case $# in
    0 )
        # Set default log path
        path="d:/logs"
        ;;
    1 )
        if [ -d "$1" ]; then
            if [ ! -x "$1" ]; then
                echo "You do not have permission."
                exit 3
            fi
        else
            echo "Directory not found."
            exit 2
        fi
        path="$1"
        ;;
    * )
        show_usage
        ;;
esac

# Go the the location of the logs
cd "$path"

# Set the name of the log file
name="$(date +%Y-%m-%d-%H%M%S).log"

# Clear adb logs and console
adb logcat -c
clear

# Start logging
adb logcat | tee $name

# TODO
# * Add filter option handling
# * No path option uses current directory
