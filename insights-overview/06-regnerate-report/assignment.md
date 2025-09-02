---
slug: regnerate-report
id: kqxenqfu6b7y
type: challenge
title: Regenerate your report
tabs:
- id: 05cyx3wlukhg
  title: Terminal
  type: terminal
  hostname: rhel
- id: ymcpmfg4bc7o
  title: Red Hat Hybrid Cloud Console
  type: external
  url: https://console.redhat.com
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Now, if you go back to Vulnerability -> Reports, and generate a new detailed report, you should see one less system listed next to the CVE we fixed.

Of course this only addressed one CVE on one system.  To perform this task at a larger scale you could select all hosts impacted by the CVE, and then use the Remediate button to either generate a playbook to fix these systems using Ansible, or remotely execute the fix if you have the proper subscriptions to do so.

