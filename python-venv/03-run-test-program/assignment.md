---
slug: run-test-program
id: c3npev5ruw2f
type: challenge
title: 'Step 3: Run a Test Program'
tabs:
- id: eyoj28spsiyb
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
enhanced_loading: null
---
A test program has been created for you already. The program uses an API (via the request library) to retrieve and print a random fact about cats. If you wish to view or modify the source code, use the following command to open it using Vim:
```bash,run
vim /home/api.py
```
If you are new to Vim, check out this helpful guide to learn the basics:

[https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-vim-101-a-beginners-guide-to-vim)

To run the test program, make sure your environment is activated. Your command line should look like this:
![](../assets/venv_activation.png)

If your environment is not activated, reactivate it with the following command:
```bash,run
source /home/python/sampleenvironment/bin/activate
```
---
Now, run the test program by running the following command:
```bash,run
python /home/api.py
```

You should see an output that contains a fact about a cat. This would not be possible without the virtual environment that was just created. To demonstrate why this would not work without the environment you set up, run the following command to deactivate your environment and then try running the program again. It will not be able to display a cat fact, and will instead print an error message.
```bash,run
deactivate
python /home/api.py
```