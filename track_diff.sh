#!/bin/bash

for i in $(find . -name "*.remote")
do
  diff -Nau $i $(dirname $i)\/$(basename $i .remote)
  if [ $? -eq 0 ]
  then 
    echo $i same, removing
    rm $i
  fi
done
