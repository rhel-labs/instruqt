---
slug: step3
id: 2hyhjhoj7dhp
type: challenge
title: Step 3
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
## Optimizing MySQL queries on Red Hat Enterprise Linux

For this step, we will be using the *Terminal* tab for MySQL commands, and *Flame* tab for perf and flame graph commands.

Apply the `throughput-performance` tuneD profile for optimizing MySQL performance on RHEL -

```bash
tuned-adm profile throughput-performance
```

Restart the MySQL service -

```bash
systemctl restart mysqld
```

To optimize query performance inside MySQL, create an index that can be used for query processing. The index will help MySQL use the index for efficiently searching matches instead of doing a full table scan.

Create a MySQL index called `ind_t1_c2` on table t1 with 50,000 rows, on the join column c2 -

```bash
mysql -A sampleDB -e "CREATE INDEX idx_t1_c2 on t1(c2);"
```

## Check the execution plan of the SELECT query with a JOIN clause

Look at the updated query execution plan that MySQL will run using the EXPLAIN statement -

```bash
mysql -A sampleDB -e "EXPLAIN format=tree SELECT COUNT(*) from t1 join t2 on t1.c2 = t2.c2;"
```

<pre class="file">
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                           |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Nested loop inner join  (cost=**7433.25** rows=18309)
    -> Table scan on t2  (cost=1025.00 rows=10195)
    -> Index lookup on t1 using **idx_t1_c2** (c2=t2.c2)  (cost=0.45 rows=2)
 |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
</pre>

Notice that in this case, the database leverages the `idx_t1_c2` index, and the overall cost of executing the query is much lesser than without the index.

## Re-run the perf command to record performance metrics for MySQL query

Use perf to record performance of the mysqld process running the same query as the previous step -

```bash
perf record -a -F 100 -g -D 100 -p $(pgrep -x mysqld) -- mysql -A sampleDB -e "SELECT COUNT(*) from t1 join t2 on t1.c2 = t2.c2;"
```

<pre class="file">
<< OUTPUT ABRIDGED >>

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (37 samples) ]

<< OUTPUT ABRIDGED >>
</pre>

The output shows the result of running the SELECT query, and the performance samples are collected in the perf.data file.

## Output the flame graph

Re-run the report option of perf script to generate an HTML report -

```bash
perf script report flamegraph
```

A new flamegraph.html file should be generated.

## Copy the report to the Apache Server

Remove index.html file from Apache, and copy the newly generated flamegraph.html file into the index.html page of the Apache web server -

```bash
rm -f /var/www/html/index.html; cp flamegraph.html /var/www/html/index.html
```

## View the flame graph in a web browser

Navigate to the *Web* tab of the lab interface and click it to view the flame graph.

This should open up another browser tab window that shows the flame graph visualization based on the perf data collected.

You will notice that now, searching the index consumes more CPU time, but overall the response time of the query is much faster.

In real-life cases, performance optimization is a continuous process - repeatedly measuring, analyzing and tuning your system, to improve performance and deliver better business outcomes.
