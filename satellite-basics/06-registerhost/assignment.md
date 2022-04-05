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
timelimit: 2400
---
<!-- markdownlint-disable MD033 -->

Navigate to the `Register Host` menu.

![reghost](../assets/reghostmenu.png)

Check the `Insecure` check box then click on `Advanced`.

![reghost1](../assets/reghost1.png)

Next, select the `RHEL8` activation key, check `Ignore errors`, check `Force`, and then click `Generate`.

![reghost2](../assets/reghost2.png)

After clicking `Generate`, a curl command will be generated. Copy and paste this command by clicking on the copy icon.

![reghost3](../assets/reghost3.png)

![copied](../assets/copied.png)

Go into the terminal of one of the rhel hosts (rhel1 or rhel2) and paste this command.

>_NOTE:_ You may need to click on the refresh button to revive the terminal. ![refresh](../assets/refresh.png)

![registering](../assets/registering.png)

When `rhel1` is registered, the following message will display in the terminal.

![registered](../assets/registered.png)

In the Satellite Web UI, navigate to `All Hosts` to view the newly registered host.

![registeredhost](../assets/registeredhost.png)

![webuiregistered](../assets/webuiregistered.png)

You can check that your host repos are configured for the Satellite server by entering the following `cat /etc/yum.repos.d/redhat.repo`

![repolist](../assets/repolist.png)

Finally, you can update your host by entering `dnf update`.

![dnfupdate](../assets/dnfupdate.png)

![dnfupdate2](../assets/dnfupdate2.png)

After updating the host, the status should turn green.

![updated](../assets/updated.png)
