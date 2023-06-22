First, move back into the directory containing the source code in C with the following command:
```
cd /home/C_source
```
Then, if you are running a C program, use GCC to compile and link the source code with the following command:
```
gcc helloworld.c -o helloworld
```
If your program is in C++, use this command to compile and link the source code:
```
gcc helloworld.cpp -o helloworld
```
Then, modify the permissions on the helloworld executable to allow it to be run with the following command:
```
chmod +x helloworld
```
Now, run your program with the following command:
```
./helloworld
```