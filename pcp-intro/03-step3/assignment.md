---
slug: step3
id: cuvb0u8ukshi
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 1
---
## Configuring PMDAs for SQL Server

The PCP Microsoft SQL Server Performance Metrics Domain Agent (PMDA) queries important performance metrics from SQL Server using SQL Servers Dynamic Management Views (DMVs).

To list the PCP PMDA packages related to Microsoft SQL Server -

```bash
yum search pcp-pmda | grep "Microsoft SQL Server"
```

<pre class="file">
Last metadata expiration check: 0:24:59 ago on Fri 12 Mar 2021 09:20:29 AM EST.
pcp-pmda-mssql.x86_64 : Performance Co-Pilot (PCP) metrics for Microsoft SQL Server
</pre>

Install the PCP PMDA package for Microsoft SQL Server -

```bash
sudo yum install pcp-pmda-mssql -y
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Installed:
  pcp-pmda-mssql-5.1.1-4.el8_3.x86_64
<< OUTPUT ABRIDGED >>
</pre>

Create a new user in SQL Server to be used by PCP. The next command uses `sqlcmd` to run a SQL script file called createUser.sql. The script creates a SQL Server user login called `pcpLogin` and only grants limited SQL Server privileges that are needed by PCP.

<pre class="file">
//Create a SQL Server login and user associated with that login. Grant VIEW SERVER STATE AND VIEW DATABASE STATE permissions to the user

CREATE LOGIN pcpLogin WITH PASSWORD = 'RedHat1!';
CREATE USER pcpUser FOR LOGIN pcpLogin;

GRANT VIEW SERVER STATE TO pcpUser;
GRANT VIEW DATABASE STATE TO pcpUser;
</pre>

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -i createUser.sql
```

View the contents of the SQL Server PMDA configuration file

```bash
cat /var/lib/pcp/pmdas/mssql/mssql.conf
```

So that PCP can connect to SQL Server with a low privileged SQL Server account, update the Login name in the configuration file

```bash
sed -i 's/sa/pcpLogin/g' /var/lib/pcp/pmdas/mssql/mssql.conf
```

Update the password corresponding to the low privileged account in the configuration file

```bash
sed -i 's/P4$$W0rd/Redhat1!/g' /var/lib/pcp/pmdas/mssql/mssql.conf
```

Make sure the configuration file is owned by the root user and group, and that appropriate permissions are set.

```bash
chown root:root /var/lib/pcp/pmdas/mssql/mssql.conf
```

```bash
chmod 400 /var/lib/pcp/pmdas/mssql/mssql.conf
```

## Install the SQL Server PMDA agent

Install the PMDA agent for SQL Server

```bash
cd /var/lib/pcp/pmdas/mssql; ./Install
```

<pre class="file">
Updating the Performance Metrics Name Space (PMNS) ...
Terminate PMDA if already installed ...
Updating the PMCD control file, and notifying PMCD ...
Check mssql metrics have appeared ... 168 metrics and 601 values
</pre>

>**Note:** The successful message indicating that mssql metrics have appeared
