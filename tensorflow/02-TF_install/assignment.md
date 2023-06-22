# Step 2: Install Tensorflow

First, we will create a conda environment for TensorFlow using Python 3.9 called "tf"

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

Finally, we can install TensorFlow from pip. We will use the CPU-only build of TensorFlow because we are not using a GPU for ML.

```bash
pip install tensorflow-cpu==2.12.*
```

To verify that Tensorflow is running properly on the CPU, run the following program, which will execute a simple python test program:

```bash
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

```

you will see an output, and the last line of output should look like this. The numbers may differ, but it should have this format:

> tf.Tensor(-838.20764, shape=(), dtype=float32)
