---
slug: time
id: zwuvqotz9gf1
type: challenge
title: Date and Time
notes:
- type: text
  contents: |
    # What is epoch time?

    Time is a fundamental part of productivity, but frameworks must be established to ensure that humans and computers can be on the same page about time. On Linux, one of these frameworks is the __unix epoch__. This is a standardized date and time that is defined as the beginning of time for unix systems. From this, an _epoch time_ (or _unix time_) is the number of seconds that have elapsed since the __unix epoch__. The __unix epoch__ is defined as Midnight UTC on January 1, 1970.

    Unix time is exceptionally well-documented online, and if you wish to learn more the [Wikipedia page](https://en.wikipedia.org/wiki/Unix_time) on the subject is a great place to start.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Now, let's try a few examples of converting between time formats. The `date` command is useful for displaying the current date and time of your system. The value output depends on the timezone you have configured, and the format of the output can be controlled using format strings. If you run `date` without any arguments, it will print the date and time in the following format:

```bash
date
```

<pre class=file>
Mon Dec  21 17:03:56 EDT 2021
</pre>

>_NOTE:_ The output should match the current date and time when you are running this lab, but it will be formatted using the Eastern Timezone since that is the default for the lab systems. Converting a date and time to epoch time is as simple as a single argument (`+%s`) with `date`. You can also specify the `-d` option to input a datetime instead of using the current one.

```bash
date -d "Dec 12 2014 20:00:00" +%s
```

This will show you the epoch time corresponding to the string you input:

<pre class=file>
1418432400
</pre>

You can convert in the reverse direction with `date` as well by using the `--date` option, then prepending a `@` symbol to the epoch time you would like to convert. This syntax specifies that you would like to know the date at the given epoch time. Try this using the epoch time you just received from the previous command:

```bash
date --date @1418432400
```

<pre class=file>
Fri Dec 12 20:00:00 EST 2014
</pre>

This results in the original date that you input a few commands ago. Notice that this specifies the date in the timezone for this lab system, Eastern Time.

For more information on using `date`, check out the [date man page](https://man7.org/linux/man-pages/man1/date.1.html).

An example of how you might run into unix time is available in this [SELinux troubleshooting article](https://www.redhat.com/sysadmin/selinux-denial2). The following example error is given:

<pre class=file>
type=AVC msg=audit(1600796109.687:168): avc:  denied  { read } for  pid=3912 comm="rhsmcertd-worker" name="virt.module" dev="dm-0" ino=50331783 scontext=system_u:system_r:rhsmcertd_t:s0 tcontext=system_u:object_r:root_t:s0 tclass=file permissive=0
</pre>

For this lab, we care about the second field in this error. You may recognize that ten digit number as a unix timestamp. To confirm, convert it to a standard date:

```bash
date --date @1600796109
```

<pre class=file>
Tue Sep 22 13:35:09 EDT 2020
</pre>

The article that this error was taken from was published on November 16, 2020, which supports the fact that this was a unix timestamp generated during the process of writing the article. However, someone who is not familiar with the unix time format may never consider that this number relates to time at all.
