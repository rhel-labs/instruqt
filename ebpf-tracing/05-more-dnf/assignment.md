---
slug: more-dnf
id: fs4r2n2inbzd
type: challenge
title: dnf continued
tabs:
- title: dnf
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "yum" > /dev/null 2>&1
- title: gethostlatency
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "gethostlatency" > /dev/null 2>&1
- title: tcplife
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "tcplife" > /dev/null 2>&1
- title: filetop
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "filetop" > /dev/null 2>&1
- title: xfsslower
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "xfsslower" > /dev/null 2>&1
- title: cachestat
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "cachestat" > /dev/null 2>&1
difficulty: ""
timelimit: 1
---
Next, `dnf` will begin installing the updates and removing old packages. To do this, `dnf` is going to use the disk and memory resources; you will monitor this using `filetop`, `xfsslower` and `cachestat`.

In the *filetop* tab, you will start to see files being read and written to disk. As `dnf` reads files from an rpm package, it writes them out to the disk. Below is what the read operations should look like:

<pre class="file">
TID    COMM             READS  WRITES R_Kb    W_Kb    T FILE
77699  dnf              7      0      2       0       R stat.h;5e5574b8
77699  dnf              3      0      0       0       R tc_defact.h;5.5574b8
77699  dnf              1      0      0       0       R rpmsg.h;5e5574b8
77699  dnf              2      0      0       0       R midi.h;5e5574b8
<< OUTPUT ABRIDGED >>
</pre>

From the above output, you can see in the Type column(T) that these are regular files(R). Further, you can see the counters in the READS column report greater than 0. This shows you in, real time, what `dnf` is doing with files on the system.

Further, on the *xfsslower* tab, you will start to see XFS operations take longer than the 10ms threshold and disk operations will start to be displayed:

<pre class="file">
Tracing XFS operations slower than 10 ms
TIME     COMM           PID    T BYTES   OFF_KB   LAT(ms) FILENAME
09:22:58 b'dnf'         77726  S 0       0         567.45 b'packages.db-journal'
09:22:58 b'dnf'         77726  S 0       0          14.21 b'packages.db-journal'
09:22:58 b'dnf'         77726  S 0       0          14.48 b'packages.db-journal'
09:22:58 b'dnf'         77726  S 0       0          13.83 b'packages.db-journal'
09:22:58 b'dnf'         77726  S 0       0          14.16 b'packages.db-journal'
09:22:59 b'dnf'         77726  S 0       0          10.07 b'packages.db-journal'
09:22:59 b'dnf'         77726  S 0       0          27.65 b'packages.db'
<< OUTPUT ABRIDGED >>
</pre>

In the above output, you see the file that `dnf` is working on and the latency in the LAT(ms) column, the data above shows that the longest latency was 567.45 milliseconds while accessing the packages.db-journal file. If you wish to improve the speed of `dnf update` on this system by reducing latency, you may want to look at upgrading the underlying storage of this system.

If you look at the *cachestat* tab, you will see that the number of misses on the cache has gone up during the `dnf` package installation procedure as it is starting to need access to data that is not cached:

<pre class="file">
    HITS   MISSES  DIRTIES  BUFFERS_MB  CACHED_MB
       0       62        0           0       1701
       0       52        0           0       1702
      45        2        0           0       1701
    5721     3777        0           0       1716
   18683     6606        0           0       1747
   14853     6223        0           0       1778
       0        2        0           0       1778

<< OUTPUT ABRIDGED >>
</pre>

If you keep watching the *cachestat* terminal, you will notice that the number of misses goes back down to zero after the `dnf update` completes. This is because when the `dnf update` is finished, the virtual machine returns to a more idle state and there is very little running that needs access to storage.
