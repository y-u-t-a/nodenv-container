#!/bin/bash

nodenv local > /dev/null 2>&1
if [ $? -eq 0 ]; then
    local_node_version=$(nodenv local)
    # Change node version
    nodenv install -f $local_node_version > /dev/null 2>&1
    nodenv local $local_node_version > /dev/null 2>&1
fi

# Execute command from argument
$@