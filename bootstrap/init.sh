#!/usr/bin/env bash

# TODO:
# Add support for more linux distros

unameStr=$(uname -v)
os=""

checkOS() {
    if grep Darwin <<< "$unameStr" >/dev/null; then
        os="OSX"
    elif grep Ubuntu <<< "$unameStr" >/dev/null; then
        os="Ubuntu"
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

install() {
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

setup() {
    if ! [ -d /etc/ansible ]; then
	echo -e "Writing Ansible configurations..."
	sudo ln -sv ../ansible /etc/ansible
    elif [ -d /etc/ansible ]; then
	echo "You already have ansible settings already present at /etc/ansible"
	
	while true; do
    	    read -p "Do you want to overwrite these settings? [Y/n]" yn
    	    case $yn in
        	[Yy]* ) echo -e "Writing Ansible configurations...\n"; sudo ln -svF ../ansible /etc/ansible; break;;
        	[Nn]* ) exit;;
        	* ) echo "Please answer yes or no.";;
    	    esac
	done
    fi	
}

checkOS
depsCheck
install
setup
