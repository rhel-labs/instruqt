---
slug: registerhost
id: 6sndovc6398z
type: challenge
title: Register a host to Satellite
teaser: Register a host to Satellite
notes:
- type: text
  contents: Register a host to Satellite
tabs:
- id: xmydgnukwa14
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: pv4zonuai9bx
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: no3tuq3j0l7i
  title: rhel1
  type: terminal
  hostname: rhel1
- id: xob0hd4ftzlf
  title: rhel2
  type: terminal
  hostname: rhel2
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Introduction
===
Now we'll register the hosts `rhel1` and `rhel2` to our Satellite server. We'll use the command line interface to generate a registration command in this lab.

It is also possible to generate a registration command from the Satellite WebUI but due to the limitations of DNS in this lab environment, we'll use the cli utility `hammer` to simplify the process.

In our registration command, we'll specify that the new host should be added to the `Application Servers` host group we just created. As well, we'll ignore certificate errors (since we're using a self signed certificate) and we will set up Insights.

Create a registration script
===
Click on the [button label="Satellite Server"](tab-0) tab.

![satellite server tab](../assets/satellite-server-tab.png)

Click on the `run` button to run the following command in the `Satellite Server` terminal.

```bash,run
hammer host-registration generate-command --hostgroup "Application Servers" --insecure 1 --setup-insights 1 --force 1
```

The output of this command is a curl command similar to this (don't copy paste this):

```nocopy
set -o pipefail && curl -sS --insecure 'https://satellite.lab/register?force=true&hostgroup_id=1&setup_insights=false' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJpYXQiOjE2ODI2MjkyNzcsImp0aSI6ImQ1YjFkYThmYzM4OGY5ZjY0MmEyZjc0ZGFhNjRkMmZjODVmZDhiNjU1Y2E3NmM3ODEyYWQ5ZjQzNWE0NWE5Y2UiLCJleHAiOjE2ODI2NDM2NzcsInNjb3BlIjoicmVnaXN0cmF0aW9uI2dsb2JhbCByZWdpc3RyYXRpb24jaG9zdCJ9.bgS1XqSYd4bsY46Suq7QqC5OSKm3bSsN57c3lddiOkU' | bash
```

Register hosts
===

In the interest of minimizing copy/paste errors, a script has been created below to register the hosts `rhel1` and `rhel2` to our Satellite server.

Make sure you are in the [button label="Satellite Server"](tab-0). Click on `run` in the right hand corner of the code block below.

```bash,run
export REGISTRATION_SCRIPT=$(hammer host-registration generate-command --hostgroup "Application Servers" --insecure 1 --setup-insights 1 --force 1)
ssh -o StrictHostKeyChecking=no rhel1 $REGISTRATION_SCRIPT
ssh -o StrictHostKeyChecking=no rhel2 $REGISTRATION_SCRIPT
```

This script obtains the global registration script and runs it on `rhel1` and `rhel2` via SSH.

In the Satellite Web UI, navigate to `All Hosts` to view the newly registered hosts.

![](../assets/registeredhost.png)

![](../assets/webuiregistered.png)

On [button label="rhel1" background="#ee0000" color="#c7c7c7"](tab-2) or [button label="rhel2" background="#ee0000" color="#c7c7c7"](tab-3), you can check that your host repos are configured for the Satellite server `satellite.lab` by running the following:

```bash,run
cat /etc/yum.repos.d/redhat.repo
```

![](../assets/repolist.png)
