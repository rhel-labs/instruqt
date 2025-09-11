---
slug: step4
id: 8nqkjygaryrs
type: challenge
title: Step 4
tabs:
- id: j2ipcqyo2nv5
  title: Terminal
  type: terminal
  hostname: rhel
- id: kkxx3l9x5kek
  title: OpenSCAP Report
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Remediating and rescanning against a profile

One of the many failed rules in the scan previously done was related to IPSec support. In this step, you will remediate a single failed rule related to IPSec support.

> [!NOTE]
> Many of the remediations involve restarting the host, and the current demo environment does not support host reboots yet. Thus, this lab will focus only on remediating a single issue.

Re-scan the host passing the *--remediation* option to carry out an online remediation. Additionally, provide
the Rule ID from the previous step (*xccdf_org.ssgproject.content_rule_package_libreswan_installed*) to remediate the specific rule. If no
Rule ID is provided, oscap attempts to remediate all the failed rules.

```bash,run
oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_pci-dss --remediate --fetch-remote-resources --results scan-xccdf-results.xml --rule xccdf_org.ssgproject.content_rule_package_libreswan_installed /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```

<pre class="file">
--- Starting Evaluation ---

Title   Install libreswan Package
Rule    xccdf_org.ssgproject.content_rule_package_libreswan_installed
Ident   CCE-84068-6
Result  fail


--- Starting Remediation ---

Title   Install libreswan Package
Rule    xccdf_org.ssgproject.content_rule_package_libreswan_installed
Ident   CCE-84068-6
Result  fixed
</pre>

To verify that the issue is remediated, re-run the previous command. Oscap only attempts to fix what is broken, so it will not remediate an already fixed rule.

```bash,run
oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_pci-dss --remediate --fetch-remote-resources --results scan-xccdf-results.xml --rule xccdf_org.ssgproject.content_rule_package_libreswan_installed /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```

<pre class="file">
--- Starting Evaluation ---

Title   Install libreswan Package
Rule    xccdf_org.ssgproject.content_rule_package_libreswan_installed
Ident   CCE-84068-6
Result  pass


--- Starting Remediation ---
</pre>

The remediation starts but there is no work left to be done.
