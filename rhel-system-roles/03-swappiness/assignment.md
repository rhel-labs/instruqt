---
slug: swappiness
id: nzslxqav3vzn
type: challenge
title: Verify the system roles and configurations were applied.
teaser: Verify the system roles and configurations were applied.
notes:
- type: text
  contents: 'Step 3: Verify the system roles and configurations were applied.'
tabs:
- id: 4cslm1sedhc1
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: u5nygmib6y7b
  title: client1
  type: terminal
  hostname: client1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Now that the playbook has been applied to the system, verify that the updated settings have been applied. Below you will see we use swappiness, but you could look at any of the included parameters.
```bash,run
cat /proc/sys/vm/swappiness
```
The result should be the following.
<pre>
20
</pre>
As expected, the setting is now 20 instead of what it started as in the beginning of the lab.

To verify that session recording is now working, ssh to the system as the rhel user.
```bash,run
ssh -o "StrictHostKeyChecking no" rhel@localhost
```
Here's the output.
<pre>
# ssh -o "StrictHostKeyChecking no" rhel@localhost
Warning: Permanently added 'localhost' (ED25519) to the list of known hosts.
Locale charset is ANSI_X3.4-1968 (ASCII)
Assuming locale environment is lost and charset is UTF-8

ATTENTION! Your session is being recorded!

[rhel@rhel ~]$
</pre>
To complete this section enter the following.
```bash,run
exit
```
You should have seen dialog similar to the output shown above. Success! the system is now recording terminal sessions for users connecting to it.

For `client1`, repeat the following command.
```bash,run
ssh -o "StrictHostKeyChecking no" rhel@client1
```
<pre>
root@rhel:~# ssh -o "StrictHostKeyChecking no" rhel@client1
<<< OUTPUT ABRIDGED >>>
ATTENTION! Your session is being recorded!
</pre>
Exit and continue to the next challenge.
```bash,run
exit
```