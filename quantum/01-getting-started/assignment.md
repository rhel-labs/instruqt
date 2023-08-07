---
slug: getting-started
id: 5biynjaxnof6
type: challenge
title: Getting Started
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: ""
---
Before we start setting up the tools for quantum software development, it will be helpful to cover some of the basics of quantum computing.

## How does quantum computing differ from classical computing?

In classical computing, information is represented by bits (binary digits). Bits are binary, meaning they can have a logical state equal to one of two values (i.e., bits are either 0 or 1).

In quantum computing, information is represented by qubits (quantum bits). Qubits can store the logical values of traditional bits (0 or 1), but they can also use [quantum superposition](https://scienceexchange.caltech.edu/topics/quantum-science-explained/quantum-superposition) to represent a proportion of 0 and 1. For example, a qubit could be 30% of 0 and 70% of 1.

To learn more about the difference between bits and qubits, check out [this helpful article](https://azure.microsoft.com/en-us/resources/cloud-computing-dictionary/what-is-a-qubit/).

In essence, a qubit's ability to store more information means that a quantum computer can process much more information.
