#!/usr/bin/env bash

# TODO:
# Test dependency checker
# Install ansible through preferred methods for various linux distros, per the documentation

unameStr=$(uname -v)
os=''

checkOS() {
    if grep Darwin <<< "$unameStr" >/dev/null; then
        os='OSX'
    elif grep Ubuntu <<< "$unameStr" >/dev/null; then
        os='Ubuntu'
    fi
}

depsCheck() {
    if ! hash git 2>/dev/null; then
	echo "Git is required, but it's not installed. Please install git & re-run the installer."
	exit 1
    elif ! hash pip 2>/dev/null; then
	echo "Pip is required, but it's not installed. Please install pip & re-run the installer."
	exit 1
    fi
}

init() {
    echo -e "\n-----------"
    echo "Preparing to install ansible & dependencies..."
    echo -e "-----------\n"

    sleep 1
    
    if [ "$os" == "OSX" ]; then   
    	sudo pip install ansible
    elif [ "$os" == "Ubuntu" ]; then 
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible
    fi

    echo -e "\n----------"
    echo "Ansible & dependencies are installed."
    echo -e "----------\n"
}

checkOS
depsCheck
init
