---
slug: create-a-database
id: zdxtpyp9lq7z
type: challenge
title: Create a Database
notes:
- type: text
  contents: In this step, you will create your SQL database. It is worth noting that
    SQL commands (generally) end in a semicolon. This is somewhat different from Linux,
    and it is a distinction that you should remember when working with SQL databases.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
difficulty: basic
timelimit: 600
---
First, begin a MySQL session by running the following command:
```bash
mysql -p
```
>Note: the -p at the end of the command allows you to log into MySQL with a password.

When prompted, enter the password you supplied earlier and then press enter:
```bash
rhel
```
The output of the previous command should resemble this:
<pre class=file>
Welcome to the MySQL monitor. Commands end with ; or \g
Your MySQL connection id is 8
Server version: 8.0.32 source distribution
<< output abridged >>
</pre>

Next, create a database called `MyDatabase`
```bash
CREATE DATABASE MyDatabase;
```
Creating your database will result in an output resembling this:
<pre class=file>
Query OK, 1 row affected (0.00 sec)
</pre>

Now, select your new server for use by running this command:
```bash
USE MyDatabase;
```
This will result in the following output:
<pre class=file>
Database changed
</pre>
>Note: every time you begin a MySQL session, you will need to select the server you wish to use via the `USE` command.
>You can view the details of your current server by running the `status` command with no arguments inside your MySQL session.

