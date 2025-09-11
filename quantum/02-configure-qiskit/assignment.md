---
slug: configure-qiskit
id: nsjkmsdzxelk
type: challenge
title: Configure Qiskit
notes:
- type: text
  contents: In this step, you will configure a virtual environment for your program.
tabs:
- id: fp4dt6d9ph0s
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
enhanced_loading: null
---
In this step, we will configure our development environment.

First, create a Conda environment for Qiskit called `qis`:

```bash
conda create --name qis python=3.9 -y
```

Then, activate the Conda environment using the following command:

```bash
conda activate qis
```

Now that the environment has been activated, install Qiskit using the following command.
```bash
pip install qiskit
```

Now install Aer, a quantum simulator that will allow you to run your code on non-quantum hardware.
```bash
pip install qiskit-aer
```

Install the data visualization module for Qiskit. This component allows for much easier data visualization and can make Qiskit more flexible.
```bash
pip install qiskit[visualization]
```

Finally, install Jupyter Notebooks, a set of tools for interacting with code in a web browser. Jupyter does not do any quantum computation; it is only for making it easier to work with our code. We will use this component later in the lab when we run a test program.
```bash
pip install notebook
```