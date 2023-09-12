---
slug: step3
id: 3rjgjunusovl
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: OpenSCAP Report
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 1
---
# Scan and generate a report

A XCCDF document is a structured collection of security configuration rules for some set of target system. In this case, it has the
configuration rules that meet the PCI regulation.

To start scanning using OpenSCAP, use the *oscap xccdf eval* command with the profile Id, option to fetch remote resources, output XML results file, and
the datastream file.

```
oscap xccdf eval --fetch-remote-resources --profile xccdf_org.ssgproject.content_profile_pci-dss --results /tmp/scan-xccdf-results.xml /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```

>__NOTE:__ This scan can take a few minutes to complete as it has to evaluate all the rules, and generate a XML file that has the results.

Once the scan completes, you can look at the pass/fail status of each rule in the output -

<pre class="file">
Downloading: https://access.redhat.com/security/data/oval/v2/RHEL9/rhel-9.oval.xml.bz2 ... ok
--- Starting Evaluation ---


...

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226913
OVAL Definition Title   RHSA-2022:6913: .NET 6.0 security and bugfix update (Moderate)
Result  pass

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226854
OVAL Definition Title   RHSA-2022:6854: gnutls and nettle security, bug fix, and enhancement update (Moderate)
Result  pass

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226839
OVAL Definition Title   RHSA-2022:6839: squid security update (Important)
Result  pass

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226838
OVAL Definition Title   RHSA-2022:6838: expat security update (Important)
Result  pass

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226763
OVAL Definition Title   RHSA-2022:6763: bind security update (Important)
Result  pass

Title   Ensure Software Patches Installed
Rule    xccdf_org.ssgproject.content_rule_security_patches_up_to_date
Ident   CCE-84185-8
OVAL Definition ID      oval:com.redhat.rhsa:def:20226717
OVAL Definition Title   RHSA-2022:6717: thunderbird security update (Important)
Result  pass

...

<< OUTPUT ABRIDGED >>
</pre>


The XML results file can be transformed into HTML or plain-text format for easier readability -

```
oscap xccdf generate report /tmp/scan-xccdf-results.xml > /var/www/html/index.html
```

Now that the HTML report is generated, you can check the *OpenSCAP Report* tab of this lab interface to view the results (You may need to refresh the OpenSCAP Report tab using the refresh button at the upper-right of the instruqt tab).

![OpenSCAP-Report](../assets/Openscan-Report-Fail.png)

In the report, you will notice that several rules have failed. If you scroll to the bottom of the HTML report, you will find a failed rule related to *IPSec Support*. If you click the failed rule, you can get more details including the Rule ID, severity and description.

![OpenSCAP-Report-Details](../assets/Openscan-Report-Fail-Details.png)

Take a note of the Rule ID for this failed rule as it will be used in the next step.

