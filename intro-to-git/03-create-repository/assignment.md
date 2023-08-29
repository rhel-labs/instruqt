---
slug: create-repository
id: 3eoz4xxdcevk
type: challenge
title: 'Step 3: Create a Repository'
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
Next, you will create a Git repository. Make a repository called "my-repo" by running the following commands
```bash
mkdir /home/my-repo #makes a directory within the home folder for your Git repository
cd /home/my-repo #changes the working directory to your Git repository
git init #creates a Git repository in the working directory
```

Next, you will need to have some files in your repository to work with. Run the following commands to put some sample files into the repository:
```bash
tee helloworld.cpp << EOF
#include <iostream>
using namespace std;
int main() {
   cout << "Hello World!" << endl;
   return 0;
}
EOF

tee helloworld.py << EOF
print("Hello World!")
EOF

tee sample.txt << EOF
Hello! This is some sample text for your Git repository:

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse laoreet placerat metus vitae pulvinar. Sed dictum dui ut metus vulputate scelerisque. Morbi molestie sem augue, at varius elit volutpat eu. Nulla eget lectus ac metus pretium molestie. Proin in dolor a arcu gravida viverra. Suspendisse gravida viverra odio, non consectetur nisi efficitur in. Pellentesque placerat tortor libero, vitae placerat nulla dignissim quis. Suspendisse ut dui quam. Nullam nec diam elit.
EOF
```

To enable Git tracking on each of these files, run the following commands:
```bash
git add helloworld.cpp
git add helloworld.py
git add sample.txt
```

Then, make an initial commit to your Git repository along with writing a commit message by running the following command"
```bash
git commit -am "added helloworld.cpp, helloworld.py, and sample.txt"
```
The output should look like this:
<pre class="file">
[main (root-commit) 18ca5a3] added helloworld.cpp, helloworld.py, and sample.txt
3 files changed, 10 insertions (+)
create mode 100644 helloworld.cpp
create mode 100644 helloworld.py
create mode 100644 sample.txt
</pre>
Commit essentially saves the changes you made to the repository. Commit messages are important because they help you understand what changes were made in each commit, making it much easier to solve problems in the future.