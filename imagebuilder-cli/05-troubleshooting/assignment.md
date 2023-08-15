---
slug: troubleshooting
id: y9zff9ryrbh2
type: challenge
title: Troubleshooting
notes:
- type: text
  contents: |+
    # Troubleshooting a compose

    Sometimes machine image builds are not successful. Looking at the logs of the build may be useful when troubleshooting.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
# Troubleshooting a compose

```
composer-cli compose log $(composer-cli compose status | cut -f1 -d" " | tail -1)
```

Throughout the lab, you have seen the UUID of the compose transaction used in
command output and as an argument for working with individual machine image
operations.  The osbuild-composer back-end also uses this UUID to store data about
this, specific, machine image build.

To look at the data associated with the machine image build you completed in the lab -

```
composer-cli compose results $(composer-cli compose status | cut -f1 -d" " | tail -1)
```

The output is a .tar that includes the logs, status, and resulting image.

To view the contents of the tar file -

```
tar -tvf $(composer-cli compose status | cut -f1 -d" " | tail -1).tar
```

You will be able to use these logs to isolate problems with a build, add fixes into your compose file, and reinitiate your build.