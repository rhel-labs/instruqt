---
slug: install-pytorch
type: challenge
title: Install TensorFlow
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
First, create a Conda environment for PyTorch called `torch`:

```bash
conda create --name torch python=3.9 -y
```

Then, activate the Conda environment using the following command:

```bash
conda activate torch
```
Your Conda environment status is shown in the command line withinin parentheses like this:
<pre class="file">
(torch) <span style="color:green;">root@rhel</span>:~#
</pre>
Next, we need to ensure that Pip, Python's package manager, is up to date. To do this, we can run the following command:

```bash
pip install --upgrade pip
```

Finally, we can install TensorFlow from pip. We will use the CPU-only build of TensorFlow because we are not using a GPU for ML on this system.

```bash
pip install tensorflow-cpu
```

To verify that Tensorflow is running properly on the CPU, run the following command, which will execute a simple python test program:

```bash
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))" 2>/dev/null

```

The output should look like this. The numbers may differ, but it should have this format:

> tf.Tensor(-838.20764, shape=(), dtype=float32)
