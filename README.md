# Introduction

A collection of simple scripts written in Bash and Python.

# Table of contents

1. make-dark.sh
2. make-install.sh
3. make-json-parse.py
4. make-logs.sh
5. make-info.sh
6. make-template.sh

# 1. make-dark.sh

Turns on the dark mode, on Android devices. It also initiates the necessary
reboot after changing the mode.

The first complete implementation of the dark mode appears in Andorid 10.

# 2. make-install.sh

Made to circumvent a limitation on Windows 8.0, when trying to install an
.apk file from a network directory via ADB in Cygwin.
I installs the app by copying it locally first.

# 3. make-json-parse.py

A rudimentary script for parsing/linting JSON text.

# 4. make-logs.sh

A way to display Android logs and save them locally at the same time.
The variable path points to the location when the logs will be saved.
A log file is created every time the script is started. The logs will use
the timestamp as name and the extension .log.

# 5. make-info.sh

Displays information about the Android device connected using the Android
Debugger command.

# 6. make-template.sh

Makes a template file for Java classes.

# TODO

[logs] Add path option
