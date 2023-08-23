---
slug: tf-test
type: challenge
title: Run a Test Program
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1400
---

If the environment is activated, the beginning of your command line will look like this:
<pre class="file">
(jupyter) <span style="color:green;">root@rhel</span>:~#
</pre>
If your Conda environment is not enabled, reenable it through the following command:

```bash
conda activate torch
```

Run the following command to run a test ML program in Python that has been created for you.

```bash
python3 /home/TF_Source/helloTF.py 2>/dev/null
```