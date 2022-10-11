---
slug: step2
id: 4z1db0bzczqf
type: challenge
title: Step 2
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
timelimit: 1
---
## Recording performance metrics using Perf

>**NOTE:** In this step we will be using the *Flame* terminal.

Select the *Flame* terminal to run commands in this step.

## Using perf to record performance metrics for MySQL query

`Perf` is a performance analysis tool in RHEL. It is based on the perf_events interface exported by the kernel, and provides a simple command line interface.

The linux perf command has 3 main parts - **action**, **event** and **scope**.

Use the perf record feature for collecting system-wide statistics - the frequency is 100 samples per second (denoted by -F), across all CPUs (denoted by -a).

Perf can also be used to record performance data for a particular process (mysqld in this lab), while it runs a specific SELECT query. The recording starts 100 milliseconds (denoted by -D) after the MySQL client is started.

```bash
perf record -a -F 100 -g -D 100 -p $(pgrep -x mysqld) -- mysql -A sampleDB -e "SELECT COUNT(*) from t1 join t2 on t1.c2 = t2.c2;"
```

> **NOTE:** Recording performance metrics can take a minute or so to complete, and you should proceed only when the command has finished executing.

<pre class="file">
<< OUTPUT ABRIDGED >>

+----------+
| COUNT(*) |
+----------+
|  6641633 |
+----------+
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.071 MB perf.data (277 samples) ]
</pre>

The output shows the result of running the SELECT query, and the performance samples are collected in the perf.data file.

Check out `man perf` if you are interested in more details about the `perf` tool.

## Output the flame graph

The report option of perf script can be used to generate an HTML format report for better readability -

```bash
perf script report flamegraph
```

To generate a command line output of the stack trace, you can use -

```bash
perf report -n --stdio
```

A flamegraph.html file should be generated.

Type `q` to exit.

## Copy the report to the Apache Server

In this lab, we have also installed Apache web server. Apache web server is not required for perf, however it is needed in this lab for the purposes of viewing the flame graph HTML report.

Copy the flamegraph.html file to the index.html page of the Apache web server -

```bash
cp flamegraph.html /var/www/html/index.html
```

## View the flame graph in a web browser

The flame graph provides an indication on what's running hot on the CPU.

Navigate to the *Web* tab of the lab interface and click it to view the flame graph. This should open up another browser tab window that shows the flame graph visualization based on the perf data collected.

If you explore the flame graph, you will notice that a lot of cycles are spent for the JOIN operation in MySQL.

## Check the query execution plan of a SELECT query with a JOIN clause

To dive deeper into how MySQL is executing a SELECT query joining two tables, look at the query execution plan using MySQL's EXPLAIN statement -

```bash
mysql -A sampleDB -e "EXPLAIN format=tree SELECT COUNT(*) from t1 join t2 on t1.c2 = t2.c2;"
```

<pre class="file">
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                           |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Inner hash join (t1.c2 = t2.c2)  (cost=**500104.14** rows=500000)
    -> Table scan on t1  (cost=0.05 rows=5000)
    -> Hash
        -> **Table scan on t2**  (cost=101.00 rows=1000)
 |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
</pre>

Note that the join operator of MySQL does a full scan on table t2, because there is no index defined on the join column (c2) on table t2.
As a table grows, the costs of doing such an operation grows, and is a performance bottleneck. This confirms the flame graph results.
