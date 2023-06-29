---
slug: step2
id: hgwyeqlt6xgy
type: challenge
title: step2
difficulty: basic
timelimit: 600
---
# Step 2: Write a Program

A directory for your source code has been created for you. Move to the C_source directory by running the following command

```bash
cd /home/C_source
```

Run the following command to create a "Hello World" program in C:

```bash
tee helloworld.c << EOF
#include <stdio.h>
int main() {
   printf("Hello, World!\n");
   return 0;
}
EOF
```

If you are running a C++ program, use this instead:

```bash
tee helloworld.cpp << EOF
#include <iostream>
int main() {
   cout << "Hello world!" << endl;
   return 0;
}
EOF
```

You can use shell tools like Vi to edit your code in RHEL, but you can also use popular text editors and IDEs including Eclipse, VSCode, Sublime Text, and CLion. These make it easier to test and collaborate on your code.
