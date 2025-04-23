---
slug: kb-articles
id: bkayqe1bni3t
type: challenge
title: Search the Red Hat Knowledge Base
teaser: Search the Red Hat Knowledge Base with Command Line Assistant.
notes:
- type: text
  contents: CLA provides an interface to knowledge and solutions authored by Red Hat
    subject matter experts. In this assignment we'll work through some examples.
tabs:
- id: rq56mcadmlns
  title: rhel
  type: terminal
  hostname: rhel
difficulty: ""
enhanced_loading: null
---

Command Line Assistant has the ability to return answers that make use of a Retrieval Augmented Generation database that provides Red Hat Enterprise Linux specific knowledge.

For example, let's try asking CLA the following question.

```bash,run
c "what is simple content access"
```

Simple Content Access (SCA) is a simplified subscription model and CLA can return the full definition and links to additional documentation.

![](../assets/sca.png)

On the topic of subscriptions, let's ask CLA how to use `subscription-manager`.

```bash,run
c "what is subscription-manager"
```

As you can see we are provided a summary on how to use `subscription-manager`.

![](../assets/subscription_manager.png)

Ansible core is included with a RHEL subscription. Ask CLA what it is.

```bash,run
c "what is ansible-core"
```

![](../assets/ansible_core.png)

That concludes this lab. Thank you for taking the time to learn more about Command Line Assistant.