---
slug: configure-git
id: 1inxlycpnvbn
type: challenge
title: 'Step 2: Configure Git'
notes:
- type: text
  contents: To ensure Git works well for you, it is a good idea to configure it properly.
    While there are many settings that can be adjusted, we will cover the most important
    ones.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
First, set a name for yourself with Git. This identifies your changes to facilitate more efficient collaboration. To set a value for name, run the following command:
```bash
git config --global user.name "Sample Name"
```

Next, set an email address. Like your name, this identifies your changes to facilitate more efficient collaboration. To set the email address, run the following command:
```bash
git config --global user.email "your_email@example.com"
```

Finally, set an initial branch name for your Git repositories. In this example, we will set it to `main`.
```bash
git config --global init.defaultBranch "main"
```