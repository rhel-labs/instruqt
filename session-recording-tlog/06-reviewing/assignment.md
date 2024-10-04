---
slug: reviewing
id: kkqnmkfry4au
type: challenge
title: Reviewing a recorded session in Web Console
tabs:
- id: 88on0mhphjix
  title: Terminal
  type: terminal
  hostname: rhel
- id: zloxmsr7yyrh
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

Navigate back over to the *Web Console* tab in your lab environment.

If you are not already on the *Session Recording* page, please navigate there.

You should now see a recorded session available.

<a href="#1">
 <img alt="An example image" src="../assets/recorded-session.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/recorded-session.png" />
</a>

After selecting the session, you will be taken to a page with an integrated player through which you can watch the session.  Press the *Play* button to review the session.

<a href="#2">
 <img alt="An example image" src="../assets/recorded-session-playback.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/recorded-session-playback.png" />
</a>

The session was recorded in real-time, so if you started the `bash` session but did not start running commands immediately, you will see that wait time reflected in the recorded session as well.

In addition to some standard video player functionality, the buttons on the right side of the player will allow you to zoom in and out to get closer, or further away, look at the content.  Also, the search function located at the bottom of the player window will search the recorded session for text and report time codes at which that string is found.  Those time codes are links, which will change the location of the playback in the player.

Below the player is additional metadata about this session as well as the log entries for the session.

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
