---
slug: step1
id: ntnuwmabzaey
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    # Goal:
    After completing this scenario, users will be able to run Microsoft SQL Server
    on Red Hat Enterprise Linux(RHEL) using UBI and Red Hat container tools.

    # Concepts included in this scenario:
    * Download the container image that contains Microsoft SQL Server
    * Deploy root and rootless container instances of SQL Server on RHEL
    * Query data in SQL Server running in a container on RHEL
    * Take a checkpoint of the container, and restore the container from the checkpoint
    * Generate systemd scripts to automatically start the SQL Server containers at system boot

    # Example Use case:
    Your infrastructure team is planning on using containerized applications, and this also means
    containerized databases. They have learnt that Microsoft SQL Server 2019 offers a container image
    for Red Hat Enterprise Linux (RHEL), and they want to start using it for building applications.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Terminal SQL Server
  type: terminal
  hostname: rhel
- title: Terminal SQL Client
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Verify the environment

Containers are an extremely popular way for developers to deliver software today.  They are more portable and lightweight than the VM images traditionally used to package software in the cloud,  while at the same time, more consistent and efficient to deploy and patch than traditional software packages used on-premises.  Microsoft delivers SQL Server 2019 for Linux containers which are supported on Red Hat Enterprise Linux (RHEL) 8 and OpenShift 4.  These containers are built using the Red Hat Universal Base Image (UBI) runtime.  In this lab, we will demonstrate how to deploy these images on RHEL 8.

> **NOTE:** In this scenario we assume that you understand the fundamentals about UBI and RHEL container tools. If you are not familiar with RHEL container tools (such as *podman*), you should consider reviewing the [Podman lab](https://lab.redhat.com/podman-deploy)

There are 3 terminal tabs that will be used in this lab - a terminal on the container host (indicated by *Terminal*), a terminal where we will run the SQL Server container (indicated by *Terminal SQL Server*), and a terminal where we will run the SQL Server client tools (indicated by *Terminal SQL Client*).

In this lab, we will be spinning up 3 instances of SQL Server, each running in a container.

On the host system, create a directory to store the script to be used for SQL Server In-memory OLTP dataset

```bash
mkdir -p /var/mssql/scripts
```

Copy the script file from the /root directory to the newly created scripts directory

```bash
cp ./imoltp.sql /var/mssql/scripts/
```

> **NOTE:** In SQL Server 2019, the container runs using a non-root user by default. The default user is *mssql* with uid *10001*. Modify and
set the appropriate user ownership for the script directory created to uid:10001 that maps to the *mssql* user.

```bash
chown -R 10001:0 /var/mssql/scripts
```
