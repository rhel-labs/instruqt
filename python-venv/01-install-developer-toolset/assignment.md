---
slug: install-developer-toolset
id: kpn6evljuxfa
type: challenge
title: 'Step 1: Install RHEL Developer Toolset'
tabs:
- id: ppt8ndy3jys9
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
---
The first step is to install Red Hat Enterprise Linux Developer Toolset. This is a group of packages which contains helpful development tools for Python, including those needed for virtual environments. It is included in all RHEL subscriptions, including the free Developer Subscription for Individuals. To install, run the following command:

```bash
dnf group install "Development Tools" -y
```

The RHEL Developer Subscription for Individuals includes:

* An entitlement to register 16 physical or virtual nodes running Red Hat Enterprise Linux
* Access to Red Hat Insights, a predictive analytics platform offering powerful tools to improve security and stability
* Complete access to Red Hat Enterprise Linux releases, updates, and errata
* Self-service support through the Red Hat Customer Portal
* Access to knowledge base articles, portal discussion groups, and magazines on the Red Hat Customer Portal

You can learn more about the no-cost RHEL Developer Subscription for Individuals here:

[https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#)
