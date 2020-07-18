#!/bin/bash

if [ $(nodenv local) ]; then
    # Change node version
    nodenv install -f `nodenv local`
    nodenv local `nodenv local`
fi

# Execute command from argument
$@