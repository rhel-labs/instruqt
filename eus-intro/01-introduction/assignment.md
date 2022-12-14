---
slug: introduction
id: mn4dexksswet
type: challenge
title: Introduction to Extended Update Support
notes:
- type: text
  contents: |
    # Introduction to Extended Update Support
    Whether you want more control over your lifecycle, need a longer support window, or are tied to a specific minor release, Extended Update Support (EUS) allows your Red Hat Enterprise Linux servers to stay on the same minor version for 2 years.

    ## Tasks included in this scenario:
    * Identify current minor version and available versions of RHEL
    * Add EUS entitlement to a server
    * Update to the latest EUS release

    ## Additional Reading:
    https://access.redhat.com/articles/rhel-eus
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
---
# What is Extended Update Support (EUS)?

EUS is an optional offering for Red Hat Enterprise Linux (RHEL) subscribers. With EUS, Red Hat provides backports of Critical and Important impact security updates and urgent-priority bug fixes for a predefined set of minor releases of Red Hat Enterprise Linux. EUS enables customers to remain with the same minor release of Red Hat Enterprise Linux for 24 months, allowing for stable production environments for mission-critical applications.

(Source: https://access.redhat.com/articles/rhel-eus)

# Why would you use EUS?

TK

# Verifying Extended Update Support Availability

TK

```
subscription-manager repos | grep -i eus
```

<pre class=file>

</pre>
