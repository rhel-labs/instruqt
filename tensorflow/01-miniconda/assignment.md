# step 1: install MiniConda

The first step to configuring Tensorflow is to install MiniConda. before we can install it, we must add its repository to Yum (the package manager). add the GPG public key and configure the repository for MiniConda with the following command:

```bash
# Import our GPG public key
rpm --import https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc

# Add the Anaconda repository
cat <<EOF > /etc/yum.repos.d/conda.repo
[conda]
name=Conda
baseurl=https://repo.anaconda.com/pkgs/misc/rpmrepo/conda
enabled=1
gpgcheck=1
gpgkey=https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc
EOF
```

You are now ready to install Conda. To install with Yum, run the following command:

```
yum install conda -y
```

Finally, run the following command to finish the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash
source /opt/conda/etc/profile.d/conda.sh
conda -V
```
