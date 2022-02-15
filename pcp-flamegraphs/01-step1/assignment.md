---
slug: step1
id: m3yesc2o4lg2
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to use flame graphs to visualize CPU performance data in the context of running a SQL query using MySQL

    # Concepts included in this scenario:
    * Get the latest version of MySQL using RHEL Application Streams
    * Install packages for the perf tool and flame graphs in RHEL
    * Record the performance of a MySQL query using perf
    * Visualize MySQL query performance using flame graphs in RHEL

    >**BACKGROUND:** Sometimes, just visualizing performance metrics can make it super easy to quickly identify a performance issue. Flame Graphs are a way of visualizing this performance data, and we’ll show you how to get started using flame graphs on Red Hat Enterprise Linux to collect and analyze data to solve your performance mysteries. In this example, we will be generating flame graphs in the context of the latest App Streams version of MySQL in RHEL.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Flame
  type: terminal
  hostname: rhel
- title: Web
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 900
---
## Validate Environment and Install Flame Graph Stack

In RHEL, there are two stacks for visualizing performance data - one based on PCP and Grafana, and the other based on perf and flame graph. For many performance troubleshooting use-cases, visualizing performance metrics is key and this lab will explain how to use the perf and flame graph stack on RHEL.

In this lab, our setup consists of a single node system running MySQL. We have set up three terminal windows running on the local machine - The current terminal window will be used for OS specific commands and to interact with MySQL. The `Flame` terminal will be used for running specific perf and flame graph commands. The `web` terminal will be used to browse the flame graph.

Use RHEL Application Streams to check if the MySQL module has been installed -

```bash
yum module list | grep 'MySQL Module'
```

<pre class="file">
mysql                8.0 [d]      client, server [d]                       MySQL Module
</pre>

MySQL is not installed. Install MySQL using RHEL Application Streams -

```bash
yum module install -y mysql:8.0
```

Verify that MySQL is installed on the system -

```bash
mysql -V
```

Start the __MySQL Daemon (mysqld)__

```bash
systemctl start mysqld
```

Check the status of the mysqld service -

```bash
systemctl status mysqld --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2021-05-17 14:42:40 EDT; 6s ago

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __active (running)__.

Install the packages needed for the perf tool, and the flame graphs -

```bash
sudo yum install -y perf js-d3-flame-graph
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Installed products updated.

Installed:
  js-d3-flame-graph-3.0.2-2.el8.noarch   libbabeltrace-1.5.4-3.el8.x86_64   libbpf-0.0.8-4.el8.x86_64   perf-4.18.0-240.22.1.el8_3.x86_64

<< OUTPUT ABRIDGED >>
</pre>

## Load sample data into the database
For this lab, there is a pre-existing `sample-testdata.sql` script which creates a database called `sampleDB` that has two tables (t1 and t2). The script generates random numeric items and loads them into the tables - table t1 with 50,000 rows, and table t2 with 10,000 rows

Before we proceed to the next step, load sample data into MySQL -

```bash
mysql < sample-testdata.sql
```

To validate that our data is loaded into the tables, count the number of rows in table t1 -

```bash
mysql -A sampleDB -e "SELECT count(*) from t1;"
```

<pre class="file">
+----------+
| count(*) |
+----------+
|    50000 |
+----------+
1 row in set (0.00 sec)
</pre>

The result shows that the rows are successfully loaded into the table t1.
