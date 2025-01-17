---
slug: run-program
id: sgim8tlkbpvd
type: challenge
title: 'Step 3: Run Your Program'
tabs:
- id: 602badmbwxhm
  title: Terminal
  type: terminal
  hostname: rhel
  workdir: /home/C_source
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
enhanced_loading: null
---
RHEL includes the GNU Compiler Collection for use with various different compiled languages, including C and C++.

If you are writing a C program, use GCC to compile and link the source code with the following command:

```bash,run
gcc helloworld.c -o helloworld
```

If your program is in C++, use this command to compile and link the source code:

```bash,run
g++ helloworld.cpp -o helloworld
```

Then, modify the permissions on the helloworld executable to allow it to be run with the following command:

```bash,run
chmod +x helloworld
```

Now, run your program with the following command:

```bash,run
./helloworld
```

If you are interested in learning more about programming in C or C++, you can check out these helpful guides to get you started:

C: [https://www.geeksforgeeks.org/c-programming-language/](https://www.geeksforgeeks.org/c-programming-language/)

C++: [https://www.geeksforgeeks.org/c-plus-plus/](https://www.geeksforgeeks.org/c-plus-plus/)
