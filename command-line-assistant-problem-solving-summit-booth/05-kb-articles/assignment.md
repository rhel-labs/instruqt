---
slug: kb-articles
id: colfgu73ujvd
type: challenge
title: Search the Red Hat Knowledge Base
teaser: Search the Red Hat Knowledge Base with command line assistant.
notes:
- type: text
  contents: Command line assistant provides an interface to knowledge and solutions
    authored by Red Hat subject matter experts. In this assignment we'll work through
    some examples.
tabs:
- id: yid7bnddd2qm
  title: rhel
  type: terminal
  hostname: rhel
difficulty: ""
timelimit: 0
enhanced_loading: null
---

Command line assistant has the ability to return answers that make use of a Retrieval Augmented Generation database that provides Red Hat Enterprise Linux-specific knowledge.

For example, let's try asking command line assistant the following question.

```bash,run
c "what is simple content access"
```

Simple Content Access (SCA) is a simplified subscription model and command line assistant can return the full definition and links to additional documentation.

![](../assets/sca.png)

On the topic of subscriptions, let's ask command line assistant how to use `subscription-manager`.

```bash,run
c "what is subscription-manager"
```

As you can see we are provided a summary on how to use `subscription-manager`.

![](../assets/subscription_manager.png)

Ansible core is included with a RHEL subscription. Ask command line assistant what it is.

```bash,run
c "what is ansible-core"
```

![](../assets/ansible_core.png)

That concludes this lab. Thank you for taking the time to learn more about command line assistant.
