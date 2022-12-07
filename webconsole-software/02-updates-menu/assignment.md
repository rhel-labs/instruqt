---
slug: updates-menu
id: a2hxquq1ajjb
type: challenge
title: Navigate to Software Updates application
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
Now that you are logged into the Web Console, we must turn on administrative access.

Click `Turn on administrative access`.

<a href="#turn-on">
 <img alt="An example image" src="../assets/turn-on-admin.png" />
</a>

<a href="#" class="lightbox" id="turn-on">
 <img alt="An example image" src="../assets/turn-on-admin.png" />
</a>

Next do the following:

1) Enter the password: **redhat**
2) Click `Authenticate`

<a href="#auth">
 <img alt="An example image" src="../assets/auth.png" />
</a>

<a href="#" class="lightbox" id="auth">
 <img alt="An example image" src="../assets/auth.png" />
</a>

Navigate to the **Software Updates** application.

<a href="#nav-updates">
 <img alt="An example image" src="../assets/Nav-Updates.png" />
</a>

<a href="#" class="lightbox" id="nav-updates">
 <img alt="An example image" src="../assets/Nav-Updates.png" />
</a>

It will take a little while to check software status.

<a href="#checking">
 <img alt="An example image" src="../assets/checking.png" />
</a>

<a href="#" class="lightbox" id="checking">
 <img alt="An example image" src="../assets/checking.png" />
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
