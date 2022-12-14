---
slug: login
id: 5gmf0ltgl4de
type: challenge
title: Logging in and navigating Web Console
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

Now that the required software is installed, it is time to configure and enable terminal session recording.  You will use the Web Console to perform this task.

Use the *Web Console* tab in your lab environment to log into the Web Console for the system.  You should use the following credentials:

Username: __rhel__
Password: __redhat__

<a href="#1">
 <img alt="An example image" src="../assets/Web-console-login.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/Web-console-login.png" />
</a>

>**NOTE:** Problems accessing the Web Console or logging in? For best results, copy and paste the URL into Google Chrome.

Next, turn on administrative access. Click on the `Turn on administrative access` button.

<a href="#2">
 <img alt="An example image" src="../assets/webconsoleadminaccess.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/webconsoleadminaccess.png" />
</a>

Enter the Password `redhat`.

<a href="#3">
 <img alt="An example image" src="../assets/enterpasswordforadminaccess.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/enterpasswordforadminaccess.png" />
</a>

Now that you are logged into the Web console, and because you have installed the __cockpit-session-recording__ rpm package, you can now select the *Session Recording* option in the left-side navigation menu.

<a href="#4">
 <img alt="An example image" src="../assets/session-recording-option.png" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/session-recording-option.png" />
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
