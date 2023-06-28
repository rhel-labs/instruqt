# Step 2: Write a Program
A directory for your source code has been created for you. Move to the C_source directory by running the following command
```bash
cd /home/C_source
```

At this point, the command line will no longer be visible, and the Vi editing environment should consume the display. In Vi, write the following simple program in C.
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