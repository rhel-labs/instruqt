#!/bin/bash

# Create an output file
touch /root/post-run.log

# register host
subscription-manager config --rhsm.manage_repos=1
subscription-manager register --org=12451665 --activationkey=${ACTIVATION_KEY} --force

# Create a done file to signal we have finished
touch /root/post-run.log.done

tee -a /root/node-app-server.toml << EOF
name = "node-app-server"
description = "Sample image for the node.js application server"
version = "0.0.1"
modules = []
groups = []
EOF