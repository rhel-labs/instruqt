---
slug: notebook-setup
id: y00fkqm2olou
type: challenge
title: Notebook Setup
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
In this step, you will set up a Jupyter Notebook to run your code. First, ensure that your Conda environment is activated. When activated, your command prompt will look like this:
![](../assets/20230630_153341_Conda_Environment_Status_copy.png)

If it is inactive, you can activate it with the following command:
```bash
conda activate tf
```

Next, install the necessary components to run the Jupyter Notebook and perform data visualization
```bash
pip install notebook matplotlib
```

Finally, start the Jupyter Notebook by running the following command:
```bash
nohup conda run -n tf jupyter notebook --ip=* --no-browser --allow-root -NotebookApp.password='redhat' -NotebookApp.token='redhat' --notebook-dir="/root/tensorflow" </dev/null >/dev/null 2>&1 &
```
The output will look like this, but the exact numbers may vary:
<pre class="file">
[1] 2877
</pre>
> Note: To learn more about the configuration and deployment of Jupyter Notebooks, take a look at our lab on managing Jupyter Notebooks! It contains more detailed explanations to help you get started with Jupyter Notebooks.
