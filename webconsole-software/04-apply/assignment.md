---
slug: apply
id: fu3txdp5srhg
type: challenge
title: Apply security updates
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

Notice that there are a mix of updates available for the system.  Some of these are identified as __Security Updates__ by the shield icon in the __Severity__ field.

Also, you will notice that there is a button in the upper left corner entitled
__Install Security Updates__.

Use the __Install Security Updates__ button to apply this set of updates.

<a href="#security">
 <img alt="An example image" src="../assets/Apply-Security-Updates.png" />
</a>

<a href="#" class="lightbox" id="security">
 <img alt="An example image" src="../assets/Apply-Security-Updates.png" />
</a>

After the security updates are applied, you are prompted to restart the system so that the updates take effect.  We are not yet finished applying updates, so, for now, please __Ignore__ the restart request.

![Ignore Restart Request](../assets/Restart-request.png)

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
