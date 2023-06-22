First, move to the C_source directory. To do this, run the following command
```
cd /home/C_source
```
Next, to open a text editor in which you can write a program called helloworld.c, run the following command:
```
vi helloworld.c
```
Alternatively, if you wish to run a C++ program, use this command instead:
```
vi helloworld.cpp
```
At this point, the command line will no longer be visible, and the Vi editing environment should consume the display. In Vi, write the following simple program in C.
```
#include <stdio.h>
int main() {
   printf("Hello, World!\n");
   return 0;
}
```
If you are running a C++ program, use this instead:
```
#include <iostream>
int main() {
   cout << "Hello world!" << endl;
   return 0;
}
```
Then, save and exit vi by pressing escape followed by the following command:
```
:wq
```