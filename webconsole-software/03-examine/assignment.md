---
slug: examine
id: esbrescoyngg
type: challenge
title: Examine available updates
tabs:
- id: ef6pu1ikbx1m
  title: Terminal
  type: terminal
  hostname: rhel
- id: zbjhbnlf0pyk
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---

You can see on the **Software Updates** application that there are several updates available for your system.
> [!NOTE]
> The available updates may not match the following screenshots

<a href="#available">
 <img alt="An example image" src="../assets/Available-Updates.png" />
</a>

<a href="#" class="lightbox" id="available">
 <img alt="An example image" src="../assets/Available-Updates.png" />
</a>

In addition to the software package names and versions, the update type is indicated in the **Severity** field.  In the **Details** section, you see the first entry in the software's changelog.

You'll be able to inspect additional information such as complete changelog entries from the package developer, Common Vulnerability and Exposures (CVE) number [if applicable], and more.

Once you have explored the information provided with the updates, please move to the next step.

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
