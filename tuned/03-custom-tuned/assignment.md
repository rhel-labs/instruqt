---
slug: custom-tuned
type: challenge
title: Create custom TuneD Profile
teaser: Create custom TuneD Profile
notes:
- type: text
  contents: 'Step 3: Let's create a custom tuned profile'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

Before we start, let's take a look at the `mssql` tuned profile we installed earlier.  Copy and paste the command below into __> Shell__.

```bash
cat /usr/lib/tuned/mssql/tuned.conf
```

You will notice here that we are including the throughput-performance profile like the virtual-guest profile did, but we have a lot more tunables which are specific to Microsoft SQL Server

You will also notice that under the [vm] heading there is a comment that if you are running a multi-instance SQL deployment, you want to use `madvise` instead of `always` for the transparent_hugepages setting.

Let’s do that via a custom TuneD profile

Since we know that the mssql profile has all the settings we need and we just want to override one variable, we can create a new TuneD profile, include the mssql profile and then override the transparent_hugepages to madvise

First lets create the directory for the new TuneD profile


Copy and paste the command below into __> Shell__.

```bash
mkdir /etc/tuned/mssql-multi
```

Next we will create a tuned.conf that includes the mssql profile and overrides transparent_hugepages to `madvise`

Copy and paste the command below into __> Shell__.

```bash
printf "[main]\nsummary=MSSQL profile for multi-instance\ninclude=mssql\n\n[vm]\ntransparent_hugepages=madvise\n" > /etc/tuned/mssql-multi/tuned.conf
```

Let's take a look at our new tuned.conf

Copy and paste the command below into __> Shell__.

```bash
cat /etc/tuned/mssql-multi/tuned.conf
```

In our next lesson, we are going to activate the new profile and validate our settings

