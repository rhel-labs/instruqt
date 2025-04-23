---
slug: timezone
id: pgm4qpkpiqqy
type: challenge
title: Get acquainted with Command Line Assistant
teaser: Let's ask Command Line Assistant for help.
notes:
- type: text
  contents: |
    Command Line Assistant is intended to make information quick and easy to access. It incorporates knowledge from resources such as the Red Hat Enterprise Linux documentation and makes it easier to find through natural language queries in the command line.
tabs:
- id: s6abcoi7xolp
  title: rhel
  type: terminal
  hostname: rhel
difficulty: ""
timelimit: 0
enhanced_loading: null
---
Welcome to the Command Line Assistant problem solving lab.

Command Line Assistant is intended to provide rapid access to Red Hat knowledge to help users solve problems as quickly as possible, through a natural language interface.

In this challenge, we'll get acquainted with the Command Line Assistant.

Run the Command Line Assistant
===
Let's ask Command Line Assistant (CLA) how to configure the timezone of our RHEL system to Vancouver, Canada. Click the run button in the top right corner of the code block below.

```bash,run
c "how do I configure the timezone to Vancouver Canada on the cli in RHEL 9"
```

Here's the output.

![](../assets/timezoneoutput.png)

Let's execute the suggested solution.

```bash,run
timedatectl set-timezone America/Vancouver
```

To view the result, run the following, as suggested by CLA.
```bash,run
timedatectl
```

![](../assets/timedatectl.png)

Let's try something more difficult. Click `Next` at the bottom corner of the screen to go to the next challenge.