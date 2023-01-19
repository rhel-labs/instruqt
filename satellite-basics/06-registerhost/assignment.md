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
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

Now we'll register the hosts `rhel1` and `rhel2` to our Satellite server. We'll use the command line interface to generate a registration command in this lab. It is also possible to generate a registration command from the Satellite WebUI but due to the limitations of DNS in this lab environment, we'll use the cli utility `hammer` to simplify the process.

Click on the `Satellite Server` tab.

<a href="#1">
 <img alt="An example image" src="../assets/satellite-tab.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/satellite-tab.png" />
</a>

Copy and paste the following command into the terminal.

```bash
hammer host-registration generate-command --activation-key RHEL9 --force 1 --insecure 1 --organization "Acme Org" --location "Vancouver"
```

Copy the output by highlighting the selected text. Once the primary click mouse, button is released, the text will be automatically saved to the clipboard.

<a href="#2">
 <img alt="An example image" src="../assets/copypaste.gif" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/copypaste.gif" />
</a>

Now click on the `rhel1` tab.

<a href="#3">
 <img alt="An example image" src="../assets/rhel1.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/rhel1.png" />
</a>

Right click and select paste to paste the command into the terminal. Finally type enter to execute the registration command.

<a href="#4">
 <img alt="An example image" src="../assets/registrationrhel1.gif" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/registrationrhel1.gif" />
</a>

When your host is registered, the output will resemble something similar below.

<a href="#5">
 <img alt="An example image" src="../assets/registrationofhost.png" />
</a>

<a href="#" class="lightbox" id="5">
 <img alt="An example image" src="../assets/registrationofhost.png" />
</a>

Register `rhel2` with the Satellite server by pasting the registration command into the CLI of `rhel2`.

In the Satellite Web UI, navigate to `All Hosts` to view the newly registered host.

<a href="#6">
 <img alt="An example image" src="../assets/registeredhost.png" />
</a>

<a href="#" class="lightbox" id="6">
 <img alt="An example image" src="../assets/registeredhost.png" />
</a>

<a href="#7">
 <img alt="An example image" src="../assets/webuiregistered.png" />
</a>

<a href="#" class="lightbox" id="7">
 <img alt="An example image" src="../assets/webuiregistered.png" />
</a>

You can check that your host repos are configured for the Satellite server `satellite.lab` by entering the following:

```bash
cat /etc/yum.repos.d/redhat.repo
```

<a href="#8">
 <img alt="An example image" src="../assets/repolist.png" />
</a>

<a href="#" class="lightbox" id="8">
 <img alt="An example image" src="../assets/repolist.png" />
</a>

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
