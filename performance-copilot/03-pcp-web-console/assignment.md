---
slug: pcp-web-console
id: yo5bc4nuctye
type: challenge
title: Utilizing PCP with the Web Console
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
## Utilizing PCP with the Web Console

One of the easiest ways to observe the performance status of a RHEL server is via the Web Console, based on the upstream Cockpit project. As the web console is built to be modular, you will need to install the plugin for PCP:

```bash
dnf install -y cockpit-pcp
```

Then start the web console:

```bash
systemctl enable --now cockpit.socket
```

Click on the `RHEL Web Console` tab.

![web console](../assets/webconsole.png)

Log into the Web Console with the following credentials.

Username

```bash
rhel
````

Password

```bash
redhat
```

Give yourself `administrative access` by clicking on `Turn on administrative access`.

<a href="#3">
 <img alt="An example image" src="../assets/adminaccess.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/adminaccess.png" />
</a>

On the dashboard, you will see the CPU and Memory usage of your system update live. To dive in deeper, you can click on `View metrics and history`

<a href="#1">
 <img alt="An example image" src="../assets/cockpit_dashboard.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/cockpit_dashboard.png" />
</a>

The services, processes, and disks are hyperlinks that take you either to more detailed graphics, the appropriate web console screen, or even the system logs. This allows for a more unified troubleshooting experience.


<a href="#2">
 <img alt="An example image" src="../assets/cockpit_perf.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/cockpit_perf.png" />
</a>

In the final step, you will start several processes and utilize the PCP suite to observe its impact on system resources.

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
