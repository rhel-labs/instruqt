---
slug: insights-vuln
id: 099efnvn5hmq
type: challenge
title: Red Hat Insights Vulnerability Service
tabs:
- title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Now that we've had a look at Advisor, let's see what's in the Vulnerability tab.

![Insights Vulnerability Tab](../assets/insights-vuln-tab.png)

Here we can see all of the vulnerabilities that Insights knows about, that our system is not patched to resolve.

![Insights vulnerability list](../assets/insights-vuln-list.png)

Note that insights allows you to filter based on severity, or even whether there is a known exploit available for a given CVE.

![Insights vulnerability filter](../assets/insights-vuln-filter.png)

Known exploits also show up with a tag in the vulnerabilities list.

![Known Exploits](../assets/insights-vuln-list-exp.png)

You can click on the CVE ID to see a list of hosts that Insights has also identified as affected by this vulnerability, or the RHSA to go to the Red Hat Security Advisory related to this vulnerability.


