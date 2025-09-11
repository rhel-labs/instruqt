---
slug: step4
id: vaarlvrm0bx2
type: challenge
title: Step 4
tabs:
- id: ls4khhtvbb7q
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Measure SQL Server Performance Metrics Using PCP

Use the PCP `pminfo` command to see a complete list of metrics run in SQL Server on RHEL.

```bash
pminfo mssql
```

<pre class="file">
<< OUTPUT ABRIDGED >>
mssql.locks.raw_average_wait_time_base
mssql.locks.raw_average_wait_time
mssql.locks.lock_wait_time
mssql.locks.lock_waits
mssql.locks.deadlocks
mssql.locks.lock_timeouts
mssql.locks.lock_requests
mssql.general.processes_blocked
mssql.general.transactions
mssql.general.logical_connections
mssql.general.user_connections
mssql.general.logouts
mssql.general.connection_reset
mssql.general.logins
mssql.general.temp_tables_creation_rate
mssql.general.active_temp_tables
mssql.buffer_node.remote_node_page_lookups
mssql.buffer_node.local_node_page_lookups
mssql.buffer_node.page_life_expectancy
mssql.buffer_node.database_pages
mssql.memory_broker_clerks.pressure_evictions
mssql.memory_broker_clerks.periodic_evictions
mssql.memory_broker_clerks.internal_benefit
mssql.memory_broker_clerks.simulation_size
mssql.memory_broker_clerks.simulation_benefit
mssql.memory_broker_clerks.size
mssql.buffer_manager.page_life_expectancy
mssql.buffer_manager.background_writer_pages
mssql.buffer_manager.checkpoint_pages
mssql.buffer_manager.page_writes
mssql.buffer_manager.page_reads
mssql.buffer_manager.readahead_time
mssql.buffer_manager.readahead_pages
mssql.buffer_manager.lazy_writes
mssql.buffer_manager.integral_controller_slope
mssql.buffer_manager.target_pages
mssql.buffer_manager.database_pages
mssql.buffer_manager.free_pages
mssql.buffer_manager.page_lookups
mssql.buffer_manager.raw_buffer_cache_hit_ratio_base
mssql.buffer_manager.raw_buffer_cache_hit_ratio
mssql.buffer_manager.buffer_cache_hit_ratio
mssql.databases.log_cache_hit_ratio
mssql.latches.average_latch_wait_time
mssql.locks.average_wait_time
mssql.plan_cache.cache_hit_ratio
</pre>

There are more than 150 metrics tracked across different SQL Server resources that PCP can capture.

Now, let's run an aggregation SQL query shown below using `sqlcmd` as a background task, and monitor the SQL wait statistics using the `pmval` command in PCP over a 10 second window. Wait statistics are one of the most important indicators to identify performance issues in SQL Server.

This is the SQL query:

`//The aggregation query over 500 million rows
SELECT SUM(Price), AVG(Price) FROM Orders;`

Enter this in the terminal:
```bash
(/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -i ~/Scripts/CSNoIndex.sql | grep 'columnstore index' &>/dev/null &) && (pmval -t 1 -T 10 mssql.os_wait_stats.waiting_tasks)
```

> **NOTE**:  The results give administrators a good indication of where the problem might exist. For example, higher CXPACKET  wait values might indicate contention due to thread parallelism, and might require adjusting the degree of parallelism (MAXDOP) in SQL Server.
