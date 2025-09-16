---
slug: aws-ec2-create
id: fyftardjmfbc
type: challenge
title: Create an AWS EC2 instance
teaser: Every cloud starts from VM
notes:
- type: text
  contents: |-
    You're about to create an EC2 instance using AWS CLI.

    Please wait while we provision the AWS account.
tabs:
- id: ztxnnyaff3si
  title: Cloud CLI
  type: terminal
  hostname: cloud-client
- id: y8t5uezws444
  title: AWS Console
  type: service
  hostname: cloud-client
  path: /
  port: 80
- id: kd64g1hqvezd
  title: Terminal
  type: terminal
  hostname: rhel
- id: 1by0dirse9n6
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 600
enhanced_loading: null
---

👋 Introduction
===============

Use the terminal to create EC2 instance:

```
aws ec2 run-instances --image-id ami-01685d240b8fbbfeb --instance-type t2.nano
```

To complete this challenge, press **Check**.
