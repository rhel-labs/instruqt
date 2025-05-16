---
slug: challenge
id: ykam9jj6cai2
type: challenge
title: Get the cape
notes:
- type: text
  contents: |
    # When technical debt comes knocking

    Hey, we've got good news, the lone wolf, **Dave** was finally fired.  You remember Dave right?  He was the one who held everything together with sheer wit.  Well, now that he's gone, we have a problem.

    The server, `server1` has some really important files on it, in /var/really-important-files, but **Dave** was the only one who had access to the server.

    We know that he always used a bastion host to connect to server1, and that machine we DO have access to.. Sort of.  We only have a standard user login that was left over from our build environment.  That server is called `rhel` and we've put you right at the console with the user credentials below:

    User:
    `rhel`

    Password:
    `redhat`


    Can you figure out how to get access to `server1`, from the `rhel` host, and get the data out of `/var/really-important-files`?

    Good luck!
tabs:
- id: b7cr9nrsauhh
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # When technical debt comes knocking

  Hey, we've got good news, the lone wolf, **Dave** was finally fired.  You remember Dave right?  He was the one who held everything together with sheer wit.  Well, now that he's gone, we have a problem.

  The server, `server1` has some really important files on it, in /var/really-important-files, but **Dave** was the only one who had access to the server.

  We know that he always used a bastion host to connect to server1, and that machine we DO have access to.. Sort of.  We only have a standard user login that was left over from our build environment.  That server is called `rhel` and we've put you right at the console with the user credentials below:

  User:
  ```bash,run
  rhel
  ```
  Password:
  ```bash,run
  redhat
  ```

  Can you figure out how to get access to `server1`, from the `rhel` host, and get the data out of `/var/really-important-files`?

  Good luck!
