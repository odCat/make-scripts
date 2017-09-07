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
#     VERSION: 1.0.0
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

# Display usage and exit, if erroneous input
if [ ! $# = 1 ]; then
	echo Usage: make_install path/to/apk/file
	exit 1
fi

# Copy the .apk file locally
cp "$1" tmp.apk

# Install the copy of the .apk file
adb install tmp.apk

# Remove the temporary .apk file
rm tmp.apk
