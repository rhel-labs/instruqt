---
slug: tf-test
id: 9hsixudmd0tf
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

If the TensorFlow environment is activated, the beginning of your command line will look like this:

![](../assets/20230630_153341_Conda_Environment_Status_copy.png)

If your TensorFlow Conda environment is not enabled, reenable it through the following command:

```bash
conda activate tf
```

Run the following command to run a test ML program in Python that has been created for you.

```bash
python3 /home/TF_Source/helloTF.py 2>/dev/null
```

If you'd like to learn more about the program you just ran, you can check out the details here:

[https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v2/notebooks/3_NeuralNetworks/neural_network.ipynb](https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v2/notebooks/3_NeuralNetworks/neural_network.ipynb)

Additionally, if you'd like to view or modify the code, you can do so by opening Vim, a shell-based code editor, by running the following command:

```bash
vim /home/TF_Source/helloTF.py
```

If you are new to Vim, check out this helpful guide to learn the basics:

[https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim)

To learn more about TensorFlow and to learn how to use it in your own programs, check out the helpful tutorials here:

[https://www.tensorflow.org/tutorials](https://www.tensorflow.org/tutorials)

In the next step, you will run the same program, but you will do so through a Jupyter Notebook. This will allow you to interact more directly with the code and understand the output more effectively.