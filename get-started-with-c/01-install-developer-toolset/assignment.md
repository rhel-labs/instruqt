---
slug: install-developer-toolset
id: qdl7kbpcrruq
type: challenge
title: 'Step 1: Install RHEL Developer Toolset'
tabs:
- id: xsahztqezlxt
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 600
---
Welcome to this lab experience for Red Hat Enterprise Linux. In this Lab, you will learn how to build and run code written in C or C++ on RHEL.

The system displayed beside this text is a Red Hat Enterprise Linux 9 system registered with Subscription Manager.

The first step is to install the Red Hat Enterprise Linux Developer Toolset. This is a group of packages which contains the compiler needed for C. It is included in all RHEL subscriptions, including the free Developer Subscription for Individuals. To install, run the following command:

```bash,run
dnf group install -y "Development Tools"
```

The RHEL Developer Subscription for Individuals includes:

* An entitlement to register 16 physical or virtual nodes running Red Hat Enterprise Linux
* Access to Red Hat Insights, a predictive analytics platform offering powerful tools to improve security and stability
* Complete access to Red Hat Enterprise Linux releases, updates, and errata
* Self-service support through the Red Hat Customer Portal
* Access to knowledge base articles, portal discussion groups, and magazines on the Red Hat Customer Portal

You can learn more about the no-cost RHEL Developer Subscription for Individuals here:

[https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux)
