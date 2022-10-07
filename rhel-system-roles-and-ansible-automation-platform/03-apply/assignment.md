---
slug: apply
id: 1vzkpuwauxxu
type: challenge
title: Apply RHEL System Roles with AAP
teaser: Apply RHEL System Roles with AAP
notes:
- type: text
  contents: Apply the RHEL System Roles with Ansible Automation Platform
tabs:
- title: AAP
  type: terminal
  hostname: aap
- title: AAP Web Console
  type: external
  url: https://aap.${_SANDBOX_ID}.instruqt.io
- title: rhel Grafana Web Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

We'll create a `Template` to execute our playbook in a `Job`.

Click on `Templates`.

![templates](../assets/templates.png)

Click `Add`.

![add template](../assets/addtemplate.png)

Select `Add job template`.

![add job template](../assets/addjobtemplate.png)

Next enter the following:

1) Give the job template a name like `Apply RHEL System Roles`.
2) Select `Production Hosts`.
3) Select the `test.yml` playbook. This playbook is imported from the git repository mentioned in the first challenge of this lab.
4) Select the `acme_ssh_key`.
5) Click `Save`.

![new job template](../assets/createjobtemplate.png)

Let's apply our RHEL system roles by launching the template we just created. Click on `Launch`.

![job run](../assets/jobrun.gif)

Proceed to the next challenge after the job has completed.
