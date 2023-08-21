---
slug: install-jupyter
id: cgzzqtsyz14z
type: challenge
title: Install Jupyter Lab
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  port: 3000
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 600
---
First, activate your virtual environment by running the following command:
```bash
conda activate jupyter
```
Once you have activated the virtual environment, the command line should look like this:
<pre class="file">
(jupyter) <span style="color:green;">root@rhel</span>:~#
</pre>
Run the following command to install Jupyter Lab, Matplotlib, and Pandas:
```bash
pip install jupyter matplotlib pandas
```
Jupyter lab will host your Jupyter Notebooks, Matplotlib is for output visualization, and Pandas is for data analysis
