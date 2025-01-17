---
slug: more-updates
id: 1bkacff1hbjm
type: challenge
title: Apply remaining available updates
tabs:
- id: k2gtyql0jpfw
  title: Terminal
  type: terminal
  hostname: rhel
- id: xjpzhet2omha
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---

In addition to targeting security updates, you may also apply all available updates on the system.

When you are ready, apply the available updates by clicking the __Install All Updates__ button.

<a href="#all">
 <img alt="An example image" src="../assets/Apply-All-Updates.png" />
</a>

<a href="#" class="lightbox" id="all">
 <img alt="An example image" src="../assets/Apply-All-Updates.png" />
</a>

Again you are asked to restart the system. This time, you can if you choose to do so.

Now your system reports that it has been updated and presents the options to `Reboot system` or `Restart services`.

![Ignore Restart Request](../assets/Restart-request.png)

This lab is now complete!
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
