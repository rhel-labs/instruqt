---
slug: clue-step2
id: jz0q0ugprbej
type: challenge
title: Decrypt the data
notes:
- type: text
  contents: |-
    Looks like you found Nate's first message, but you know how he likes to complicate things.

    Hopefully you can find the next clue he needs to escape the machine...
tabs:
- id: eyjvot9j4rz2
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: ""
timelimit: 1
enhanced_loading: null
---
>Congratulations on completing the first step, your first flag code is: `m9XAhvBC`

In case you have forgotten, this is the last bit of the clue you recieved from Nate in /var/log/messages:


```nocopy
... the next clue is stored in a gpg encrypted file
in my home directory.  You will have to be me to
unencrypt it.  My passphrase is:
Super733t

I used --pinentry-mode=loopback when encrypting
it, you might need to use it too.
```
