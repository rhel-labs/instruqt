---
slug: using-your-jupyter-notebook
id: mwhdqs4vkhax
type: challenge
title: Using your Jupyter Notebook
notes:
- type: text
  contents: In this step, you will run and test the Jupyter Notebook.
tabs:
- id: zywykd7dbh1m
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: qgv8a0g4kc2l
  title: Juypter Notebook
  type: service
  hostname: rhel
  port: 8888
  new_window: true
difficulty: basic
timelimit: 600
enhanced_loading: null
---
First, launch Jupyter Lab:
```bash,run
jupyter notebook --ip=* --no-browser --allow-root -NotebookApp.password='redhat' -NotebookApp.token='redhat' --notebook-dir="/root/notebook"
```
>Explanation of the command:
> * `jupyter notebook` specifies that you want to create a Jupyter Notebook
> * `-ip=*` allows the notebook to accept connections from any IP address
> * `--no-browser` stops the program from trying to open the browser on the system hosting the server
> * `--allow-root` allows you to run a Jupyter server as the root user
> * `-NotebookApp.password='redhat'` sets the password to `redhat`
> * `-NotebookApp.token='redhat'` sets the login token to `redhat`
> * `--notebook-dir="/root/notebook"` sets the folder for your Jupyter to a subdirectory of your root directory called `notebook`. This directory and the files inside it were created by this lab.

Click on the `Jupyter Notebook` tab near the top of the lab window. This will open your Jupyter Notebook in a new tab.

When presented with a login screen, enter `redhat` into the password box and click `Log in`.
![](../assets/jupyter-login.png)

When you reach the notebook's main menu, click on the check box to the left of `population.ipynb`, and then click open.
![](../assets/jupyter_open.png)

First, take a look at the Jupyter Notebook. You'll notice that is structured as code surrounded by formatted text, offering context as to what the code is doing. In its current state, there is no visible output from your code. To view the output of your code, you will need to run the program.

To run all of the code, click on the button pictured below:
![](../assets/jupyter_play_neural.png)

Next, you will be prompted with a dialog box asking whether you wish to restart the kernel. Click `Restart`.
![](../assets/jupyter_confirm.png)
The kernel will restart and your program will run. This will take a few seconds to finish.

The output should look like this:
Part 1 output sample:
![](../assets/jupyter_part1_output.png)

Part 2 output sample:
![](../assets/jupyter_part2_output.png)

You have now successfully used a Jupyter Notebook in Red Hat Enterprise Linux! This concludes the lab instructions, but feel free to explore and modify the Jupyter Notebook in this virtual machine.