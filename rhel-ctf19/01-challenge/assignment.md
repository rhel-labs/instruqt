---
slug: challenge
id: zgybe2sdr0z1
type: challenge
title: Asset identification
notes:
- type: text
  contents: |
    # Asset identification
    In this challenge, you will act as a system administrator responsible for exploring a Red Hat Enterprise Linux system.

    You need to find out what is running on the system, but you have no information about the hardware or software.

    You will use an Ansible playbook created by the previous administrator. This playbook will help you gather important details such as the hostname, OS version, IP address, open ports, protocols, and services.

    Your task is to troubleshoot, run the playbook and analyze the report to understand the system better.
tabs:
- id: 5nwqp2j8jenr
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Asset identification

You are a sys-admin with sudo access, you need to collect the infomation about the 2 machines that are on your network.

The past sys-admin had a ansible playbook to collect a report on Hostname, OS Version, IP address and open ports, protocalls and services.

Joey the new Jr. Sys-admin, set up a new bastion box called "rhel" and knows the other machine on the network is called "node05". He copied over the ansible folders, but doesn't know how to use ansible.

Find the playbook, run it, and troubleshoot the issue.

You can check that the report ran if you can find files from the 2 machine in the same directory as the playbook.

Once it has run, click check.