# Step 1: Install RHEL Developer Toolset
Welcome to this lab experience for Red Hat Enterprise Linux. In this Lab, you will learn how to build and run code written in C on RHEL.

The system displayed beside this text is a Red Hat Enterprise Linux 9
system registered with Subscription Manager.

The first step is to install Red Hat Enterprise Linux Developer Toolset. This contains the compiler needed for C. To install, run the following command:
```bash
yum group install "Development Tools" -y
```