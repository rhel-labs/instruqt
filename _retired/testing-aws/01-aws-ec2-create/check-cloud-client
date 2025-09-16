#!/bin/bash
instanceCount=$(aws ec2 describe-instances | jq -r '.Reservations[0].Instances | length')
if [[ $instanceCount -lt 1 ]]; then
  fail-message 'Please create an instance to proceed'
fi
