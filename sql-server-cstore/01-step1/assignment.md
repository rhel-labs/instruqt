---
slug: step1
id: 3xrat5dyewfc
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to use, and modify RHEL tuned profiles using tuned-adm, and see the impact of that change with Microsoft SQL Server's columnstore feature.

    # Concepts included in this scenario:
    * Verify whether SQL Server is installed on the system
    * View the currently set RHEL tuned-profile
    * Check SQL Server query performance by running an sample analytic query with columnstores
    * Change the RHEL tuned-profile for SQL Server
    * Query SQL Server with columnstores to see the impact of the mssql tuned profile

    >**BACKGROUND:** Columnstore indexes were first introduced in SQL Server 2012. Columnstore feature is available on SQL Server on Linux, and it  offers a new way to store the data in a columnar fashion. This improves the performance of certain analytical queries by at least ten times and are extremely useful in data warehousing scenarios.
tabs:
- id: bmxy1ophjlul
  title: Terminal
  type: terminal
  hostname: rhel
- id: zlx9jqzjguvn
  title: cpudist
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
enhanced_loading: null
---
# Validate the SQL Environment

>**Note:** For this scenario, we have started installing SQL Server in the background. The background task will take between 2-5 minutes to complete.

We have setup two terminal windows running on the local machine - The current terminal will be used for SQL Server and OS specific commands. The *cpudist* terminal will be used for performance tracking using the cpudist bcc-tool explained later.

To check if ansible installation is complete, we can use the following command -

```
systemctl status mssql-server.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Monday 2019-07-15 19:24:18 EDT; 3h 59min left

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __active (running)__.

Finally, verify that you can connect to SQL Server

```
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -Q "select @@version"
```

<pre class="file">
Microsoft SQL Server 2019 (RTM-CU8) (KB4577194) - 15.0.4073.23 (X64)
        Sep 23 2020 16:03:08
        Copyright (C) 2019 Microsoft Corporation
        Enterprise Evaluation Edition (64-bit) on Linux (Red Hat Enterprise Linux 8.6) <X64>

(1 rows affected)
</pre>

By the above output, we have confirmed that we can connect to SQL Server, and confirm that we are running SQL Server 2019 on Red Hat Enterprise Linux 8.6
