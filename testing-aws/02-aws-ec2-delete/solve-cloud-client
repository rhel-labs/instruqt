#!/bin/bash
readarray -t my_array < <(aws ec2 describe-instances | jq -c '.Reservations[]')
for item in "${my_array[@]}"; do
  for instanceId in $(echo "$item" | jq -r '.Instances[].InstanceId'); do
    echo "$instanceId"
    aws ec2 terminate-instances --instance-ids "$instanceId"
  done
done
