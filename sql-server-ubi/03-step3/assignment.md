---
slug: step3
id: hkoxkavs7vqx
type: challenge
title: Step 3
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
## Multiple container instances of SQL Server

### Deploying a container as root user

In the *Terminal SQL Server* tab of the lab interface, create a container runtime using podman in the root user context - passing in-container access to the created script directory, and mapping the host port (1400) to the container's port (1433). TCP port *1433* is the default port for SQL Server.

Pass in the flag to programatically accept the EULA agreement, and setup SQL Server with the provided sa account password.
Set the hostname of the container to *mssqlcontainer0*

```bash
podman run --name mssqlDB0 --hostname=mssqlcontainer0 -d -v /var/mssql/scripts:/var/opt/mssql/scripts:Z -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=RedHat1!' --cap-add cap_net_bind_service --cap-add CAP_SYS_ADMIN -p 1400:1433 -it mcr.microsoft.com/mssql/rhel/server:2019-latest
```

At this point, there should be a container up and running, and SQL Server should also be running using non-root (*mssql*) inside this container.

To confirm this, run the *podman ps* command in the root context -

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE                                            COMMAND               CREATED        STATUS        PORTS                   NAMES
9df179d4e116  mcr.microsoft.com/mssql/rhel/server:2019-latest  /opt/mssql/bin/sq...  4 seconds ago  Up 4 seconds ago  0.0.0.0:1400->1433/tcp  mssqlDB0
</pre>

The output of podman shows 1 running container named *mssqlDB0*.

Get the top 2 lines of the container logs for database instance 0

```bash
podman logs -t mssqlDB0 | head -2
```

<pre class="file">
SQL Server 2019 will run as non-root by default.
This container is running as user mssql.
<< OUTPUT ABRIDGED >>
</pre>

> **NOTE:** We have instantiated the container runtime using the __root__ user. However, in SQL Server 2019, the container runs using a non-root user (*mssql*) by default.

### Deploying a container as a non-root user

Now, switch user context from the root user to the non-root __rhel__ user so that you don't use root privileges for the podman commands.

Recall that the __rhel__ user's password is __redhat__.

```bash
ssh rhel@localhost
```

Create a container runtime using podman which port maps the host port (1401) to the container's port (1433), passes the EULA flag, and sets up SQL Server with the provided sa account password. TCP port *1433* is the default port for SQL Server. The hostname of the container is set to *mssqlcontainer1*

```bash
podman run --name mssqlDB1 --hostname=mssqlcontainer1 -d -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=RedHat1!' --cap-add cap_net_bind_service -p 1401:1433 -it mcr.microsoft.com/mssql/rhel/server:2019-latest
```

Similarly, spin up database instance 2 of SQL Server using podman which port maps the host port (1402) to the container's port (1433), passes the EULA flag, and sets up SQL Server with the provided sa account password. TCP port *1433* is the default port for SQL Server. The hostname of the container is set to *mssqlcontainer2*

```bash
podman run --name mssqlDB2 --hostname=mssqlcontainer2 -d -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=RedHat1!' --cap-add cap_net_bind_service -p 1402:1433 -it mcr.microsoft.com/mssql/rhel/server:2019-latest
```

> **NOTE:** We have instantiated multiple container instances using a non-root *rhel* user. Additionally, in SQL Server 2019, the container runs using a non-root user (*mssql*) by default.

Get the top 2 lines of the container logs for database instance 1

```bash
podman logs -t mssqlDB1 | head -2
```

<pre class="file">
SQL Server 2019 will run as non-root by default.
This container is running as user mssql.
</pre>

Get the top 2 lines of the container logs for database instance 2

```bash
podman logs -t mssqlDB2 | head -2
```

<pre class="file">
SQL Server 2019 will run as non-root by default.
This container is running as user mssql.
</pre>

At this point, there should be 2 non-root containers spinned up using a non-root user (*rhel*), and SQL Server should also be running using non-root (*mssql*) user inside each of the containers.

To confirm this, run the *podman ps* command -

```bash
podman ps
```

<pre class="file">
CONTAINER ID  IMAGE                                            COMMAND               CREATED         STATUS          PORTS                   NAMES
9eaffcd5350f  mcr.microsoft.com/mssql/rhel/server:2019-latest  /opt/mssql/bin/sq...  17 seconds ago  Up 16 seconds ago  0.0.0.0:1402->1433/tcp  mssqlDB2
9aee201922e6  mcr.microsoft.com/mssql/rhel/server:2019-latest  /opt/mssql/bin/sq...  25 seconds ago  Up 24 seconds ago  0.0.0.0:1401->1433/tcp  mssqlDB1
</pre>

The output of podman shows 2 running containers named *mssqlDB1* and *mssqlDB2*

Exit the ssh session to go back to the root context on the host machine-

```bash
exit
```
