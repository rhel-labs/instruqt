#!/bin/sh
# Run this script from ../instruqt/
for i in `ls`; do if [ -d $i ]; then   cd $i;   instruqt track checksum;   cd .. ; fi ; done