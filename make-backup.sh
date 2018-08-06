#!/bin/bash
#==========================================================================
#        FILE: make_backup.sh
#
# DESCRIPTION: A simple script to back up files
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.0
#     CREATED: 06.07.2018
#==========================================================================

#==========================================================================
# Copyright 2018 Mihai Gătejescu
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

# Display usage and exit, if erroneous input
if [ ! $# == 1 ]; then
	echo Usage: make_backup file_to_backup
	exit 1
fi

# Set the back up name
backup_name="$(date +%Y%m%d%H%M%S)-$1.bak"

# Make back up
cp -f $1 $backup_name
