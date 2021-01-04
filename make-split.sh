#!/bin/bash
#==========================================================================
#        FILE: make_split.sh
#
# DESCRIPTION: Splits one file into multiple files
#              The default number is two
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.0.0
#     CREATED: 03.07.2019
#==========================================================================

#==========================================================================
# Copyright 2019, 2021 Mihai Gătejescu
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
	echo "Usage: $0 file [number of splits]" 1>&2
	exit 1
}

case $# in
    0 )
        show_usage
        ;;
    1 )
        if [ -f "$1" ]; then
            declare -i middle=$(wc -l $1 | cut -d' ' -f1)/2
            base_name=$(basename $0)
            name1="${base_name%%.*}1.${base_name##*.}"
            name2="${base_name%%.*}2.${base_name##*.}"
            head "-$middle" $1 > $name1
            tail "--lines=+$middle" $1 > $name2
            echo "File $1 split into $name1 and $name2."
        else
            echo "File $1 not found."
            exit 2
        fi
        ;;
    # 2 )
    #     echo "Not implemented yet."
    #     exit 11
    #     ;;
    * )
        show_usage
        ;;
esac

#TODO
# Make the script accept the number of resulting split files
