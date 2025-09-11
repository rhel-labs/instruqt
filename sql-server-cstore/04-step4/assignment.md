---
slug: step4
id: 1zgvbbp2vvul
type: challenge
title: Step 4
tabs:
- id: xlvsgjgfyycz
  title: Terminal
  type: terminal
  hostname: rhel
- id: bkndwdkeulp0
  title: cpudist
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Measure CPU performance impact with tuned profiles

To measure CPU performance, we will be using a bcc-tool called `cpudist`.

`cpudist` summarizes task on-CPU time as a histogram, showing how long tasks spent on the CPU before being descheduled. Results show CPU oversubscription (too many tasks for too few processors), overhead due to excessive context switching (e.g. a common shared lock for multiple threads), uneven workload distribution, too-granular tasks, and more.

Switch to term *cpudist* terminal

Now, let's run the columnstore index workload using sqlcmd as a background task, and monitoring CPU performance using `cpudist`.

```
(/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -i ~/Scripts/CSIndex.sql | grep 'columnstore index' &>/dev/null &) && (/usr/share/bcc/tools/cpudist 10 1 -p $(systemctl status mssql-server.service --no-pager | grep '/opt/mssql/bin/sqlservr' | sed -n 2p | cut -c14-19))
```

>**Note:** In the command above, we pass as an argument to `cpudist`, the process id (pid) of the SQL Server process by using an embedded `systemctl` command.

<pre class="file">
   usecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 2        |***                                     |
        16 -> 31         : 22       |****************************************|
        32 -> 63         : 15       |***************************             |
        64 -> 127        : 12       |*********************                   |
       128 -> 255        : 12       |*********************                   |
       256 -> 511        : 21       |**************************************  |
       512 -> 1023       : 9        |****************                        |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 2        |***                                     |
     16384 -> 32767      : 1        |*                                       |
     32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 1        |*                                       |
    262144 -> 524287     : 1        |*                                       |
</pre>

With default kernel CPU scheduler tuning,  tasks were able to run between 4096-16383 usecs (1usec = 1 microsecond) before being descheduled. This is shown in the bi-modal distribution in the `cpudist` result above.

Now, switch the tuned profile to the mssql tuned profile, which will add more finer granularity to the kernel CPU scheduler

```
tuned-adm profile mssql
```

Re-run the CPU performance measurement around the SQL Server process

```
(/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -i ~/Scripts/CSIndex.sql | grep 'columnstore index' &>/dev/null &) && (/usr/share/bcc/tools/cpudist 10 1 -p $(systemctl status mssql-server.service --no-pager | grep '/opt/mssql/bin/sqlservr' | sed -n 2p | cut -c14-19))
```

<pre class="file">
     usecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 53       |                                        |
         8 -> 15         : 365      |****                                    |
        16 -> 31         : 1960     |*************************               |
        32 -> 63         : 1496     |*******************                     |
        64 -> 127        : 1436     |******************                      |
       128 -> 255        : 2761     |***********************************     |
       256 -> 511        : 3087     |****************************************|
       512 -> 1023       : 495      |******                                  |
      1024 -> 2047       : 15       |                                        |
      2048 -> 4095       : 1        |                                        |
      4096 -> 8191       : 1        |                                        |
      8192 -> 16383      : 1        |                                        |
     16384 -> 32767      : 0        |                                        |
     32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 2        |                                        |
    131072 -> 262143     : 1        |                                        |
</pre>

When the kernel CPU scheduler is tuned appropriately using the mssql tuned profile, there is more consistent scheduling because of increased CPU granularity assigned by the kernel. This is shown by the continous distribution in the `cpudist` result above.

The mssql tuned profile enables Columnstores in SQL server to better utilize the CPU. This means that shorter tasks can be completed in shorter time windows, compared to previously where they had larger time windows and thus wasted unused CPU cycles.

