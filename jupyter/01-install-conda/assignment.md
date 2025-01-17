---
slug: install-conda
id: cizuf4ykkpux
type: challenge
title: Install Conda
notes:
- type: text
  contents: |
    # Goal: Run a Jupyter Notebook
    # Overview:

    After completing this scenario, users will be able to install Jupyter Lab and the necessary components to run a Jupyter Notebook using Red Hat Enterprise Linux.

    # Concepts included in this scenario:

    * Data visualization
    * Python package management
    * Extra Packages for Enterprise Linux (EPEL)
tabs:
- id: ldbfzs1cw4oj
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
enhanced_loading: null
---
To install Conda, we must add its repository to the package manager. To enable this, we need to add EPEL (Extra Packages for Enterprise Linux). EPEL is a repository derived from Fedora that provides additional development tools for RHEL.

```bash,run
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

You are now ready to install Conda. To install, run the following commands:

```bash,run
dnf install -y conda #installs Conda
conda init bash #configures Conda to our shell
exec $SHELL #restarts the shell to finish installation of Conda
```


Run the following command to verify the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash,run
conda -V
```
Finally, run the following command to create a Conda environment for Jupyter Notebooks.
```bash,run
conda create --name jupyter python=3.9 -y
```