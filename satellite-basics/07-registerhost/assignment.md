---
slug: registerhost
id: yv5wwjog2ddt
type: challenge
title: Register a host to Satellite
teaser: Register a host to Satellite
notes:
- type: text
  contents: Register a host to Satellite
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel2
  type: terminal
  hostname: rhel2
difficulty: basic
timelimit: 1
---
Introduction
===
Now we'll register the hosts `rhel1` and `rhel2` to our Satellite server. We'll use the command line interface to generate a registration command in this lab.

It is also possible to generate a registration command from the Satellite WebUI but due to the limitations of DNS in this lab environment, we'll use the cli utility `hammer` to simplify the process.

In our registration command, we'll specify that the new host should be added to the `Application Servers` host group we just created. As well, we'll ignore certificate errors (since we're using a self signed certificate) and we won't set up Insights.

Create a registration script
===
Click on the [button label="Satellite Server"](tab-0) tab.

![satellite server tab](../assets/satellite-server-tab.png)

Click on the `run` button to run the following command in the `Satellite Server` terminal.

```bash,run
hammer host-registration generate-command --hostgroup "Application Servers" --insecure 1 --setup-insights 0 --force 1
```

The output of this command is a curl command similar to this (don't copy paste this):

```nocopy
set -o pipefail && curl -sS --insecure 'https://satellite.lab/register?force=true&hostgroup_id=1&setup_insights=false' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJpYXQiOjE2ODI2MjkyNzcsImp0aSI6ImQ1YjFkYThmYzM4OGY5ZjY0MmEyZjc0ZGFhNjRkMmZjODVmZDhiNjU1Y2E3NmM3ODEyYWQ5ZjQzNWE0NWE5Y2UiLCJleHAiOjE2ODI2NDM2NzcsInNjb3BlIjoicmVnaXN0cmF0aW9uI2dsb2JhbCByZWdpc3RyYXRpb24jaG9zdCJ9.bgS1XqSYd4bsY46Suq7QqC5OSKm3bSsN57c3lddiOkU' | bash
```
Copy the output by highlighting the selected text. Once the primary click mouse, button is released, the text will be automatically saved to the clipboard.

![](../assets/copypaste.gif)

Register hosts
===
Now click on the [button label="rhel1"](tab-2) tab.

![](../assets/rhel1.png)

Right click and select paste to paste the command into the terminal. Finally type enter to execute the registration command.

![](../assets/registrationrhel1.gif)

When your host is registered, the output will resemble something similar below.

![](../assets/registrationofhost.png)

Register `rhel2` with the Satellite server by pasting the registration command into the CLI of `rhel2`.

In the Satellite Web UI, navigate to `All Hosts` to view the newly registered host.

![](../assets/registeredhost.png)

![](../assets/webuiregistered.png)

You can check that your host repos are configured for the Satellite server `satellite.lab` by running the following:

```bash,run
cat /etc/yum.repos.d/redhat.repo
```
![](../assets/repolist.png)