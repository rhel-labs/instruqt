---
slug: 03-swappiness
id: nzslxqav3vzn
type: challenge
title: Verify the system roles and configurations were applied.
teaser: Verify the system roles and configurations were applied.
notes:
- type: text
  contents: 'Step 3: Verify the system roles and configurations were applied.'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
- title: client1
  type: terminal
  hostname: client1
- title: client2
  type: terminal
  hostname: client2
difficulty: basic
timelimit: 600
---
Now that the playbook has been applied to the system, verify that the updated settings have been applied. Below you will see we use swappiness, but you could look at any of the included parameters.
```
cat /proc/sys/vm/swappiness
```
The result should be the following.
<pre>
20
</pre>
As expected, the setting is now 20 instead of what it started as in the beginning of the lab.

To verify that session recording is now working, ssh to the system as the rhel user with the password of redhat.
```
ssh rhel@localhost
```
Here's the output.
<pre>
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
rhel@localhost's password: redhat


ATTENTION! Your session is being recorded!
</pre>
To complete this section enter the following.
```
exit
```
You should have seen dialog similar to the output shown above. Success! the system is now recording terminal sessions for users connecting to it.

For `client1` and/or `client2`, repeat the following command.
```
ssh rhel@client1
```
<pre>
root@rhel:~# ssh rhel@client1

ATTENTION! Your session is being recorded!
</pre>
Exit and continue to the next challenge.
```
exit
```