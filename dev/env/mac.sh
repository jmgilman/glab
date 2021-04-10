#!/usr/bin/env bash

installWithBrew() {
    echo "Check if $1 is installed..."
    brew list $1 &> /dev/null
    if [[ $? -gt 0 ]]
    then
        echo "Installing $1..."
        brew install $1
    else
        echo "Upgrading $1..."
        brew upgrade $1
    fi
}


echo "Check if brew is installed..."
command -v brew &> /dev/null
if [[ $? -gt 0 ]]
then
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

DEPENDENCIES=("python3" "ansible")

echo "Updating/upgrading brew..."
brew update

for DEPEND in ${DEPENDENCIES[@]}
do
    installWithBrew ${DEPEND}
done

echo "Done!"