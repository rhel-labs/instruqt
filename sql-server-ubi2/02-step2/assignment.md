---
slug: step2
id: wbcdj3ng1adl
type: challenge
title: Step 2
tabs:
- id: vdpcf4waf5gg
  title: Terminal
  type: terminal
  hostname: rhel
- id: ywnrsgaxwqe5
  title: Terminal SQL Server
  type: terminal
  hostname: rhel
- id: ytsaseuh8fcv
  title: Terminal SQL Client
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Download the Microsoft SQL Server container image

With the new container image for SQL Server on Linux for RHEL 8 from Microsoft, you get the reliability, security features, and performance of SQL Server running fully supported on RHEL regardless of whether you are running on baremetal or virtual servers in private or public clouds.

In the context of the *rhel* user, use *podman* to get the container image that includes SQL Server. The server image also includes the client tools necessary to connect to SQL Server.

In the *Terminal* tab, run the following command.

```bash
podman pull mcr.microsoft.com/mssql/rhel/server:2019-latest
```

Verify that the SQL Server container image is now available on the host system

```bash
podman images
```

In the output, you will notice that we have a new image in the repository which is SQL Server container image (*mcr.microsoft.com/mssql/rhel/server*)

<pre class="file">
REPOSITORY                            TAG           IMAGE ID       CREATED       SIZE
mcr.microsoft.com/mssql/rhel/server   2019-latest   c9ce21305ef5   3 weeks ago    1.58 GB
</pre>
