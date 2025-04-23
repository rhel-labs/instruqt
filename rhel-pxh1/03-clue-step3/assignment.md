---
slug: clue-step3
id: gtqnfspzctmk
type: challenge
title: Configure the website
notes:
- type: text
  contents: |-
    Looks like you found Nate's message, but you know how he likes to complicate things.

    Hopefully you can find the next clue he needs to escape the machine...
tabs:
- id: xmmgnrx2ysbi
  title: Terminal
  type: terminal
  hostname: rhel
- id: jp3vev7v9d6w
  title: Local website
  type: service
  hostname: rhel
  port: 80
difficulty: ""
timelimit: 1
enhanced_loading: null
---
>Congratulations on completing the second step, your second flag code is: `NdLk4J3q`


In case you have forgotten, this is the last bit of the clue you recieved from Nate:


```nocopy
I was able to drop the next bit of the passkey into an
image in a web content directory in /website.

I know, it's super weird but I could not get into /var.  To
access the data, you will have to configure a web server
to share /website as the default site.  Also, make sure
SELinux is running in enforcing mode, it's keeping
some crazy processes contained, and if it's disabled,
they may escape and do things niether of us want
(especially me).
```
