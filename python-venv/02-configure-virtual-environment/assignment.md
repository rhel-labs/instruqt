---
slug: configure-virtual-environment
id: agpbsnjyhy3d
type: challenge
title: 'Step 2: Configure a Virtual Environment'
tabs:
- id: r1sxwgerwglx
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
---
First, create a virtual environment in Python:

```bash
python -m venv /home/python/sampleenvironment
```

>Explaination of the command:
>
>* the -m flag runs a library module as a script
>* the venv keyword indicates the creation of a virtual environment using the venv module in Python
>* the location of the virtual environment is indicated by /path/to/new/virtual/environment

Next, activate your new virtual environment:

```bash
source /home/python/sampleenvironment/bin/activate
```

Upon completing this step, the beginning of your command line should look like this:
![](../assets/venv_activation.png)

>[!NOTE]
>If you wish to deactivate your environment at any time, run the following command `deactivate`

>[!IMPORTANT]
>The following steps will require that your virtual environment is activated.

Ensure that Pip, Python's package manager, is up to date by running the following command:

```bash
pip install --upgrade pip
```

`pip` is updated quite frequently so it is best to update it natively like we did above.

---

The commands below are necessary for our test program, but the packages you install in your virtual environments will depend entirely on the requirements of your programs.

In your new environment, run the following command to install the requests library, which will allow you to make API calls in your program:

```bash
pip install requests
```

Next, run the following command to install the Pandas library, which allows for more readable terminal output of JSON files:

```bash
pip install pandas
```

Finally, install the package for Tabulate, which will turn our Pandas output into a table for terminal output:

```bash
pip install tabulate
```
