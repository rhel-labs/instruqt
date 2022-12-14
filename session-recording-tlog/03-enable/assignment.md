---
slug: enable
id: daen6fqjhmtc
type: challenge
title: Configuring and enabling session recording
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

The *Session Recording* application is initially blank, reporting __No recorded sessions__.  Click the *gear icon* in the upper right-hand corner to be taken to the configuration settings for session recording.

<a href="#1">
 <img alt="An example image" src="../assets/session-recording-initial.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/session-recording-initial.png" />
</a>

On the resulting page, you will be offered access to configuration information for session recording.  For the purpose of this scenario, you will accept most of the defaults and under the __SSSD Configuration__ section at the bottom of the page, select the *Scope* of *All*, which will apply session recording to all users and groups that open sessions on the system.

<a href="#2">
 <img alt="An example image" src="../assets/all-scope-selected.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/all-scope-selected.png" />
</a>

Once you click the *Save* button, Web Console will write out a small configuration file detailing the scope for the sssd daemon.

After saving the configuration, return the Web Console to the main *Session Recording* page.

<a href="#3">
 <img alt="An example image" src="../assets/return-main-session-page.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/return-main-session-page.png" />
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
