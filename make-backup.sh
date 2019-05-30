#!/bin/bash
#==========================================================================
#        FILE: make_backup.sh
#
# DESCRIPTION: A simple script to back up files
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 2.0
#     CREATED: 06.07.2018
#==========================================================================

#==========================================================================
# Copyright 2018 Mihai Gătejescu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#==========================================================================

# Back up a file
backup_file()
{
    file=$(basename $1)

    # Set the back up sufix
    sufix="BACKUP--$(date +%Y-%m-%d-%H%M%S)"

    # Make back up in the current directory
    backup_name="$sufix.$file"
    echo "Copying $1 to $backup_name..."

    cp -pf $1 "$backup_name"
}

# Define show_usage() function
show_usage()
{
	echo "Usage: $0 file_to_backup" 1>&2
	exit 1
}

echo $#

if [ $# -eq 0 ]; then
	show_usage
else
    for file in $@ ; do
        if [ -f $file ]; then
            backup_file $file
        else
            echo "The file $file does not exist" 1>&2
        fi
    done

    echo "Done." && echo
fi
