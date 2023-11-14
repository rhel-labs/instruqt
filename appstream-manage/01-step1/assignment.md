---
slug: step1
id: husngqy62qxt
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    # Goal:

    After completing this scenario, users will be able to choose which version of a software package is enabled on a system from an application stream.

    # Concepts included in this scenario:
    * Verify the availability of an application stream
    * Install software managed as an application stream
    * Change to a different version of software from an application stream
    * List all available software managed as application streams

    # Example Usecase:

    A web application being deployed on Red Hat Enterprise Linux 9 requires ruby version 3.0.  Later, the application is updated and requires ruby version 3.1 be available on the machine.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "Terminal1" > /dev/null 2>&1
difficulty: basic
timelimit: 3100
---
Determine the available version of ruby available in the base RHEL 9 distribution.

```bash
dnf list ruby
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Available Packages
ruby.x86_64                      3.0.4-160.el9_0                      rhel-9-for-x86_64-appstream-rpms
</pre>

Generally, the version of software provided with the base RHEL 9 distribution is the one that will be longer term supported for RHEL 9. For ruby, version 3.0 will be supported until the end of maintenance in 2032.

