---
slug: install-git
id: hdahsho84u25
type: challenge
title: 'Step 1: Install Git'
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
To use Git, it must be installed on your system. In this step, you will install Git along with other useful programming software.
First, install git by running the following command
```bash
dnf install -y git
```

Next, install Red Hat Developer Toolset. While it is not necessary for Git, it contains many helpful tools for programming. It is included in all RHEL subscriptions, including the free Developer Subscription for Individuals. To install, run the following command:
```bash
dnf group install -y "Development Tools"
```

The RHEL Developer Subscription for Individuals includes:

* An entitlement to register 16 physical or virtual nodes running Red Hat Enterprise Linux
* Access to Red Hat Insights, a predictive analytics platform offering powerful tools to improve security and stability
* Complete access to Red Hat Enterprise Linux releases, updates, and errata
* Self-service support through the Red Hat Customer Portal
* Access to knowledge base articles, portal discussion groups, and magazines on the Red Hat Customer Portal

You can learn more about the no-cost RHEL Developer Subscription for Individuals here:

[https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#)
