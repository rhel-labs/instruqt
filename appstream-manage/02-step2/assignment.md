---
slug: step2
id: dydhqwvdr6nb
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "Terminal1" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
To support the web application deployed on this machine, install ruby version 3.0.

```bash,run
dnf -y install ruby
```

After the installation is complete, verify that ruby version 3.0 is installed on the system.

```bash,run
dnf list ruby
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Installed Packages
ruby.x86_64                     3.0.4-160.el9_0                      @rhel-9-for-x86_64-appstream-rpms
</pre>


Finally, run the ruby command to inspect the version it reports.

```bash,run
ruby --version
```

<pre class=file>
ruby 3.0.4p208 (2022-04-12 revision 3fa771dded) [x86_64-linux]
</pre>
