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
Run the following command to install Jupyter Lab:
```bash
pip install jupyter
```
Next, install Matplotlib, Numpy, and Pandas:
```bash
pip install matplotlib numpy pandas
```
Jupyter lab will host your Jupyter Notebooks, Matplotlib is for output visualization, and Pandas is for data analysis

Next, launch Jupyter Lab:
```bash
jupyter notebook --ip=* --no-browser --allow-root -NotebookApp.password='redhat' -NotebookApp.token='redhat' --notebook-dir="/root/notebook"
```
>Explanation of the command:
> * `jupyter notebook` specifies that you want to create a Jupyter Notebook
> * `-ip=*` allows the notebook to accept connections from any IP address
> * `--no-browser` stops the program from trying to open the browser on the system hosting the server
> * `-NotebookApp.password='redhat'` sets the password to `redhat`
> * `-NotebookApp.token='redhat'` sets the login token to `redhat`
> * `--notebook-dir="/root/notebook"` sets the folder for your Jupyter to a subdirectory of your root directory called `notebook`. This directory and the files inside it were created by this lab.

