#!/bin/bash

echo -e '\n# Install MYBOX ...'
rebuild=true
if [ "$1" == "--no-rebuild" ]; then
    shift
    go install -v mybox
else
    echo '# Rebuilding all packages and commands ...'
    go install -a -v mybox
    echo
fi

if [ ! $? -eq 0 ]; then exit 1; fi;

echo -e "\n# Testing MYBOX ..."
go test -v mybox/provider

if [ ! $? -eq 0 ]; then exit 1; fi;

echo -e "\n# Running MYBOX..." 
mybox
