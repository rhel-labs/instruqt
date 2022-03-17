---
slug: step2
id: ytjbj2hfqxc3
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 300
---
# Logging in and navigating Web Console

Now that the required software is installed, it is time to configure and enable terminal session recording.  You will use the Web Console to perform this task.

Use the *RHEL Web Console* tab in your lab environment to log into the Web Console for the system.  You should use the following credentials:

Username: __rhel__
Password: __redhat__

![Web Console Login](../assets/Web-console-login.png)

>**NOTE:** Problems accessing the Web Console or logging in?  Try popping the Web Console page into a stand alone window by clicking this icon on the Web Console tab in the lab interface:

![Web Console Login](../assets/pop-out.png)

Now that you are logged into the Web console, and because you have installed
the __cockpit-session-recording__ rpm package, you can now select the
*Session Recording* option in the left-side navigation menu.

![Web Console Navigation](../assets/session-recording-option.png)


