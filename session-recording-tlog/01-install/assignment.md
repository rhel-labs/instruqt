---
slug: install
id: zzxlhhp2kg6b
type: challenge
title: Installing software
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to enable Terminal
    Session Recording and review recorded sessions.

    # Concepts included in this scenario:
    * Installing software for Terminal Session Recording
    * Enabling and recording terminal sessions
    * List recorded sessions
    * Replay recorded sessions using Web Console
    * Replay recorded sessions using the __tlog__ command

    # Example Usecase:
    An administrator on your team is having difficulty performing a task on a
    machine.  You would like to review what has been done to see the state of
    the machine and task.

    # Lab Feedback
    If you would like to report any bugs or make suggestions on how we can improve our labs, [please leave us a message here](https://github.com/rhel-labs/instruqt/discussions/categories/general).

    # YouTube
    For more information about Red Hat Enterprise Linux, we invite you to view our [YouTube channel]([**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)). [**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)

    If you are interested in learning critical administration skills for Red Hat Enterprise Linux, you might be interested in our show [Into the Terminal](https://www.youtube.com/playlist?list=PLXJyD2dL4oqeX-C3MvsMUJuEzWM4vLK2C).

    Here are our [playlists](https://www.youtube.com/@RedHatEnterpriseLinux/playlists). You can find various playlists on topics such as product updates and Satellite configuration and administration.

    # Reddit
    Come find us on Reddit at r/redhat.
    https://www.reddit.com/r/redhat/
tabs:
- id: 9jyhbspbxbi4
  title: Terminal
  type: terminal
  hostname: rhel
- id: ghopiojkm0fc
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
---

Install two rpm packages, __cockpit-session-recording__ and __tlog__.

```bash,run
yum install -y cockpit-session-recording tlog
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Installed:
  cockpit-session-recording-4-2.el8.noarch
  tlog-8-2.el8.x86_64

Complete!
</pre>

The first package, __cockpit-session-recording__ will add an additional feature Web Console which you will be using to enable and configure session recording. The __tlog__ package will provide the tools which will be used to both record and view the recorded terminal sessions.
