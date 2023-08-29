---
slug: create-branch
id: cys2a4amnymx
type: challenge
title: 'Step 4: Create a Branch'
notes:
- type: text
  contents: The space you are currently working in is the main branch. When collaborating
    with others, it is important to ensure that the code in the main branch works
    properly. When someone wants to make a change, it is typically best to make a
    branch of the repository, which essentially acts like a copy of the repository.
    This allows you to make changes, and once ready, merge the changes back into the
    main branch.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  workdir: /home/my-repo
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
First, Make a new branch in your repository called "experimental_change" by running the following command:
```bash
git branch experimental_change
```

Then, use checkout to switch to the new branch
```bash
git checkout experimental_change
```
The output should look like this:
<pre class="file">
Switched to branch 'experimental_change'
</pre>

Next, for the sake of demonstrating changes in Git, run the following command to modify the files in your repository:
```bash
#adds some text to the end of sample.txt
tee -a sample.txt << EOF
This is some addtional sample text. It is appended to the original sample.txt file.
EOF

#deletes helloworld.cpp
rm helloworld.cpp

#removes "World" from the output of helloworld.py and replaces it with "user"
sed -i 's/World/user/' helloworld.py
```

Finally, commit these changes to the experimental_change branch by running the following command:
```bash
git commit -am "made random changes to all files"
```
The output should look like this:
<pre class="file">
[experimental_change 8f223de] made changes to all files
3 files changed, 2 insertions (+), 7 deletions(-)
delete mode 100644 helloworld.cpp
</pre>
