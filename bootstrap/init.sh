#!/usr/bin/env bash

# TODO:
# Test dependency checker
# Install ansible through preferred methods for various linux distros, per the documentation

os='unknown'

checkOS() {
    if [ "$(uname)" == "Darwin" ]; then
        os='OSX'
    elif [ "$(uname)" == "Linux" }; then
        os='Linux'
    fi
}

depsCheck() {
    hash git 2>/dev/null || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
    hash pip 2>/dev/null || { echo >&2 "I require pip but it's not installed.  Aborting."; exit 1; }
}

init() {
    printf 'Preparing to install ansible & dependencies... \n'
    sleep 1
    echo 'Please enter password:'
    sudo pip install paramiko PyYAML Jinja2 httplib2 six ansible
}

checkOS
depsCheck
init
