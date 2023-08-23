---
slug: miniconda
type: challenge
title: Install Miniconda
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
The first step to configure TensorFlow is to install Miniconda, which allows us to set up programming environments. Before we can install it, we must add its repository to the package manager. To enable this, we need to add EPEL (Extra Packages for Enterprise Linux). EPEL is a series of community-derived packages designed to increase the flexibility of working with Red Hat Enterprise Linux.
```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
```

You are now ready to install Miniconda. To install, run the following commands:

```bash
dnf install conda -y #installs Miniconda
conda init bash #configures conda to our shell
exec $SHELL #restarts the shell to finish installation of Miniconda
```

Finally, run the following command to verify the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash
conda -V
```
