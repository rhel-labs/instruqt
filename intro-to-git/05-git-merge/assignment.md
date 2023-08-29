---
slug: git-merge
id: bg8juxzwsymd
type: challenge
title: 'Step 5: Merge Branches'
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  workdir: /home/my-repo
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
You have made changes to your experimental_change branch and are now ready to incorporate those changes into your main branch. To do this, you will pull the changes to the main branch and then delete the experimental_change branch. Additionally, when merging branches, you must be in the branch that you want to apply the changes to. For example, in this case, you will move into the main branch before merging the experimental_change branch.

To initiate a merge of experimental_change's changes into main, run the following commands:
```bash
git checkout main #moves back into the main branch
git merge experimental_change #pulls changes from experimental_change into main
```
The output should look like this:
<pre class="file">
Switched to branch 'main'
Updating to 18ca5a3..8f223de
Fast-forward
helloworld.cpp | 6 ------
helloworld.py  | 2 +-
sample.txt     | 1 +
3 files changed, 2 insertions (+), 7 deletions(-)
delete mode 100644 helloworld.cpp
</pre>

Typically, merging works well, but if there are conflicts that could not be resolved automatically, you will have to sort through them. This is a broad topic, but you can learn more about it here:
[https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)

Now that you have merged the branches, you are ready to delete the experimental_change branch. To do this, run the following command:
```bash
git branch -d experimental_change
```

You have now learned the basics of Git in Red Hat Enterprise Linux!