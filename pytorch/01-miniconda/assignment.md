---
slug: miniconda
id: kb03g3iahznd
type: challenge
title: Install Miniconda
notes:
- type: text
  contents: |
    # Overview:
    In this lab, you will learn how to install PyTorch and run a neural network-based machine learning program using Python.

    # Goal:
    After completing this scenario, users will be able to install and configure PyTorch using Red Hat Enterprise Linux.

    # Concepts included in this scenario:
    * Adding repositories to the package manager
    * Setting up a programming environment using Conda
    * Running programs written in Python
    * Machine learning
tabs:
- id: m6oeg6f7kx2x
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
enhanced_loading: null
---
There are several ways to install and manage versions of PyTorch, we're going to use Conda. Conda is an open source package and environment manager for Python, popular in the data science community.  This is an alternative to solutions like pipenv, venvs, or other Python package managers.

We'll install Conda from  Extra Packages for Enterprise Linux (EPEL),  a series of community-derived packages designed to increase the flexibility of working with Red Hat Enterprise Linux. We will also need some development packages provided by the CodeReady Linux Builder (CRB) repository. Certain packages within EPEL may have runtime dependencies on these packages not included with the usual RHEL repositories.
```bash,run
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

You are now ready to install Conda via dnf. To configure `conda` we'll run the init subcommand to configure our shell. This permanently adds the appropriate shell functions to our login envionrment. In this case, we are using the `bash` shell, but conda supports other shells as well.  To ensure we pick up the changes written to the global shell configurtions without having to log out and log back in, we'll reexec our current shell.

```bash,run
dnf install -y conda
conda init bash
exec $SHELL
```

Note that the prompt now shows `(base)` in front of the user name. This is the default environment Conda creates. Finally, run the following command to verify the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash,run
conda -V
```
