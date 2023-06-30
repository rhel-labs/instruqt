---
slug: tf-test
id: 9hsixudmd0tf
type: challenge
title: Run a Test Program
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 600
---
Ensure your TensorFlow Conda environment is enabled through the following command:

```bash
conda activate tf
```

If the TensorFlow environment is activated, the beginning of your command line will look like this:

![](using-tensorflow-with-red-hat-enterprise-linux/assets/20230630_153341_Conda_Environment_Status_copy.png)

Run the following command to run a test ML program in Python that has been created for you.

```bash
python3 /home/TF_Source/helloTF.py 2>/dev/null
```

Additionally, if you'd like to view or modify the code, you can do so by opening Vim, a shell-based code editor, by running the following command:

```bash
vim /home/TF_Source/helloTF.py
```

If you are new to Vim, check out this helpful guide to learn the basics:

[https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim)
