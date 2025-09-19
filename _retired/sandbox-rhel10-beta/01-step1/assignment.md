---
slug: step1
id: 69svp3suj3si
type: challenge
title: Red Hat Enterprise Linux Open Lab
notes:
- type: text
  contents: |
    # Goal:

    Depends on you!

    This is an environment without pre-planned lab content intended
    to be a place where you can explore a Red Hat Enterprise Linux system on
    a topic of your choosing.

    <blockquote>
    <p>
    <strong>NOTE:</strong> This lab environment will expire in about 60 minutes.
    </p>
    </blockquote>

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
- id: iksv8aygupm1
  title: RHEL 10 Terminal
  type: terminal
  hostname: rhel
  cmd: ssh -o "StrictHostKeyChecking no" root@rhel10beta
- id: l2amt2dod1me
  title: RHEL 9 Virtualization Host
  type: terminal
  hostname: rhel
- id: 5iuqkc5pxrpy
  title: RHEL 9 Virtualization Host Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
Welcome to this open lab experience for Red Hat Enterprise Linux.

The system displayed beside this text is a Red Hat Enterprise Linux 10 beta
system registered with Subscription Manager.
An unprivileged user also exists on the system.

Username: __rhel__
Password: __redhat__

Enjoy your unstructured lab time. The system will disconnect after about
60 minutes.
