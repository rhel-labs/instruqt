---
slug: getting-started
id: 5biynjaxnof6
type: challenge
title: Getting Started
notes:
- type: text
  contents: |
    # What is a quantum computer?
    Quantum computers leverage [quantum mechanics](https://www.energy.gov/science/doe-explainsquantum-mechanics) to make calculations. In practice, they can be useful for highly complex computation such as physics simulations or breaking existing encryption algorithms.

    # How does quantum computing differ from classical computing?

    In classical computing, information is represented by bits (binary digits). Bits are binary, meaning they can have a logical state equal to one of two values (i.e., bits are either 0 or 1).

    In quantum computing, information is represented by qubits (quantum bits). Qubits can store the logical values of traditional bits (0 or 1), but they can also use [quantum superposition](https://scienceexchange.caltech.edu/topics/quantum-science-explained/quantum-superposition) to represent a proportion of 0 and 1. For example, a qubit could be 30% of 0 and 70% of 1.

    To learn more about the difference between bits and qubits, check out [this helpful article](https://azure.microsoft.com/en-us/resources/cloud-computing-dictionary/what-is-a-qubit/).

    In essence, a qubit's ability to store more information means that a quantum computer can process much more information.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: ""
---
Before we start setting up the tools for quantum software development, it will be helpful to cover some of the basics of quantum computing.
# What is a quantum computer?
Quantum computers leverage [quantum mechanics](https://www.energy.gov/science/doe-explainsquantum-mechanics) to make calculations. In practice, they can be useful for highly complex computation such as physics simulations or breaking existing encryption algorithms.

# How does quantum computing differ from classical computing?

In classical computing, information is represented by bits (binary digits). Bits are binary, meaning they can have a logical state equal to one of two values (i.e., bits are either 0 or 1).

In quantum computing, information is represented by qubits (quantum bits). Qubits can store the logical values of traditional bits (0 or 1), but they can also use [quantum superposition](https://scienceexchange.caltech.edu/topics/quantum-science-explained/quantum-superposition) to represent a proportion of 0 and 1. For example, a qubit could be 30% of 0 and 70% of 1.

To learn more about the difference between bits and qubits, check out [this helpful article](https://azure.microsoft.com/en-us/resources/cloud-computing-dictionary/what-is-a-qubit/).

In essence, a qubit's ability to store more information means that a quantum computer can process much more information.

# Quantum simulation stack on RHEL:
There are numerous ways to simulate quantum computing, each with unique pros and cons, but this is the configuration we will use in this lab:
1. Red Hat Enterprise Linux 9
2. [Conda](https://docs.conda.io/en/latest/)
3. [Qiskit](https://qiskit.org/)
4. [Aer](https://qiskit.org/ecosystem/aer/)
5. [Jupyter](https://jupyter.org/)

To install Conda, we must add its repository to the package manager. To enable this, we need to add EPEL (Extra Packages for Enterprise Linux). EPEL is a repository derived from Fedora that provides additional development tools for RHEL.

```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

You are now ready to install Conda. To install, run the following commands:

```bash
dnf install -y conda #installs Conda
conda init bash #configures conda to our shell
exec $SHELL #restarts the shell to finish installation of Conda
```


Finally, run the following command to verify the installation of Conda. It will print out the version of Conda that is installed to confirm that the installation of Conda is complete:
```bash
conda -V
```
In the next step, you will configure the programming environment.