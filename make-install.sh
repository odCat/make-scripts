#!/bin/bash
#==========================================================================
#        FILE: make_install.sh
#
# DESCRIPTION: A workaround that allows adb install of an .apk file by
#              by temporarily copying it in the current directory.
#              Until I find how to make cygwin paths work with
#              adb install.
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.1.3
#     CREATED: 07.09.2017
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
    echo "Usage: $0 [option] path/to/apk/file" 1>&2
    exit 1
}

case $# in
    1 )
        cp "$1" tmp.apk
        ;;
    2 )
        if [ ${1:0:1} == "-" ]; then
            option=$1
            cp "$2" tmp.apk
        else
            echo Usage: make_install [-rg] path/to/apk/file
            exit 1
        fi
        ;;
    * )
        show_usage
        ;;
esac

# Install the copy of the .apk file
if [ $option ]; then
	adb install $option tmp.apk 2>&1 > /dev/null
else
	adb install tmp.apk 2>&1 > /dev/null
fi

if [ $? == 0 ]; then
    echo Success
fi

# Remove the temporary .apk file
rm tmp.apk
