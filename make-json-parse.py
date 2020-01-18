#!/usr/bin/python3
#==========================================================================
#        FILE: make-json-parse
#
# DESCRIPTION: Parse a json string into a readble format
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.0.0
#     CREATED: 10.10.2017
#==========================================================================

#==========================================================================
# Copyright 2017, 2018, 2019, 2020 Mihai Gătejescu
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

import sys

if sys.version_info[0] < 3:
    def inline():
        return raw_input()
else:
    def inline():
        return input()

# TODO: use exception handling
while True:
    jstring = inline()
    if not jstring:
        break
    tab = temp = ''
    tabspaces = '    '

    for i in jstring:
       if i == '{': 
            tab += tabspaces 
            temp += '{\n' + tab
       elif i == ':':
            temp += ': '
       elif i == ',' or i == ', ':
            temp += ',\n' + tab 
       elif i == '}':
            tab = tab[0:len(tab) - len(tabspaces)] 
            temp += '\n' + tab + '}'
       else:
            temp += i 

    #jstring = temp
    print(temp)
