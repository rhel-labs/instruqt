# step 1: install MiniConda

The first step to configuring Tensorflow is to install MiniConda. before we can install it, we must add its repository to the package manager. To enable this, we need to add EPEL (Extra Packages for Enterprise Linux). EPEL is a repository derived from Fedora that provides additional development tools for RHEL

```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
```

You are now ready to install Conda. To install, run the following commands:

```bash
dnf install conda -y #installs MiniConda
conda init bash #configures conda to our shell
exec $SHELL #restarts the shell to finish installation of MiniConda
```

Finally, run the following command to verify the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash
conda -V
```
