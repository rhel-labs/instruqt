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
Run the following command to install Jupyter Lab:
```bash
pip install jupyter
```
Next, install Matplotlib, Numpy, and Pandas:
```bash
pip install matplotlib numpy pandas
```
Jupyter Lab will host your Jupyter Notebooks, Matplotlib is for output visualization, and Pandas is for data analysis continue to the next step to run a Jupyter Notebook.