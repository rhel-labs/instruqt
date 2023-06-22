# Step 2: Install Tensorflow

First, we will create a conda environment for TensorFlow using Python 3.9 called "tf"
```bash
conda create --name tf python=3.9
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

