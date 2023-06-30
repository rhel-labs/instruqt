---
slug: install-tensorflow
id: yu4epayr4ayi
type: challenge
title: Install TensorFlow
difficulty: basic
timelimit: 600
---
First, we will create a conda environment for TensorFlow

```bash
conda create --name tf python=3.9 -y
```

Then, we will activate our conda environment using the following command:

```bash
conda activate tf
```

Next, we need to ensure that pip, Python's package manager, is up to date. To do this, we can run the following command:

```bash
pip install --upgrade pip
```

Finally, we can install TensorFlow from pip. We will use the CPU-only build of TensorFlow because we are not using a GPU for ML on this system.

```bash
pip install tensorflow-cpu
```

To verify that Tensorflow is running properly on the CPU, run the following program, which will execute a simple python test program:

```bash
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))" 2>/dev/null

```

The output should look like this. The numbers may differ, but it should have this format:

> tf.Tensor(-838.20764, shape=(), dtype=float32)
