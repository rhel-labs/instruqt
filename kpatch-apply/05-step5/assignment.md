---
slug: step5
id: cmdhommrbymn
type: challenge
title: Step 5
tabs:
- id: 6botdyf4wm7f
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: blvmczi32p1r
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Identifying CVEs within kpatches

In each kpatch-patch package there is a changelog of what was added to the
patchset and which CVE it applies.  You can view the changelog by using the
`rpm` command on the kpatch-patch package.  Below, we use a bit of embedded
command-line scripting to make sure that the package referenced for the
changelog is the one you installed earlier.

```bash,run
rpm -q --changelog $(rpm -qa | grep kpatch-patch)
```

![cote](../assets/cve-with-arrow.png)

In the above sample output, you can see that the latest entry, the first one
listed, in the patchset was to resolve CVE-2023-32233.

## Supporting Kernel Live Patches

Red Hat will maintain a patchset for Extended Update Support (EUS) releases
for up to one year. (see the [Red Hat Enterprise Linux 9 Life Cycle](https://access.redhat.com/support/policy/updates/errata#RHEL8_and_9_Life_Cycle) for more details)
Kernel Live Patches are made for selected Important and Critical severity CVEs.

Systems are not meant to run with Kernel Live Patched kernels forever.  It is
expected that after an organization has live patched a running kernel that
they will, at some point, schedule a maintenance window to apply an updated
kernel package to the system and perform a system reboot, thus normalizing the
system.  Kernel Live Patching allows the organization to determine when this
window occurs rather than the release of a fix for a Critical CVE.

For the most exact guidance for what is supported by Red Hat, check out this
[Is live kernel patch (kpatch) supported in Red Hat Enterprise Linux?](https://access.redhat.com/solutions/2206511) Knowledge Base article.

## Additional resources from Red Hat

In this lab, you worked with the commands and steps to list, apply, and
validate applying a Kernel Live Patch to a system.  How would an administrator
know that this was needed or available for a system?

The Red Hat Product Security team maintains a list of CVEs affecting Red Hat
products.  [Vulnerability Responses](https://access.redhat.com/security/vulnerabilities)
, [Red Hat CVE Database](https://access.redhat.com/security/security-updates/#/cve)

Each listed CVE will have a page used for additional information and resources
to go with it.  [Page for CVE-2023-32233](https://access.redhat.com/security/cve/cve-2023-32233)

On the above linked page, in addition to more information about the CVE and
the effect on systems or services, Red Hat may provide additional resources
like detection scripts to see if your system configuration is vulnerable to
the CVE.
