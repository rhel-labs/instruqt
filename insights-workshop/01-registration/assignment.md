---
slug: registration
id: vdoxvedzv6s2
type: challenge
title: Registering a machine to Red Hat Insights
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to register a system with
    Red Hat Insights and remediate issues that the Advisor tool has identified on
    the system.

    # Concepts included in this scenario:
    * Register a system with Red Hat Insights
    * View Insights Advisor results that are reported for the system on cloud.redhat.com
    * Apply a recommeded remediation for the system
    * Validate the remediation by updating system information

    # Example Usecase:
    Administrators want to know about problematic configurations prior to
    experiencing problems on systems.  Insights Advisor will look at data
    provided to the Advisor service and compare it against known problematic
    configurations and not only warn administrators through the service, but
    provide step-by-step remediation instructions and often times an Ansible
    playbook which can remediate the issue.


    Feel free to try out other Insights included services like Vulnerability,
    Compliance, Patch, and more.  We may add additional labs targeted to those
    Insights applications as well.
tabs:
- id: hogkg9kex1mt
  title: Terminal
  type: terminal
  hostname: rhel
- id: 7mb05xpz9aai
  title: Red Hat Insights
  type: browser
  hostname: insights
difficulty: basic
timelimit: 3000
enhanced_loading: null
---

In most Red Hat Enterprise Linux 9 installations, the insights-client software will be installed by default.  However, the minimal package set does not include installing the insights-client package and other versions of Red Hat Enterprise Linux, while the package is available, will likely need it installed.  Install the insights-client package on the system.

```bash,run
dnf -y install insights-client
```

Next, register your system with Red Hat Insights.

```bash,run
insights-client --register
```

<pre class=file>
Successfully registered host rhel-2e23a Automatic scheduling for Insights has been enabled.
Starting to collect Insights data for rhel-2e23a
Uploading Insights data.
Successfully uploaded report from rhel-2e23a to account 6227255.
View the Red Hat Insights console at https://cloud.redhat.com/insights/
</pre>

From the above output, you can observe that the system has been successfully registered with Red Hat Insights.  As part of the registration, the machine also uploads a report to Red Hat Insights so that it may be analyzed for any issues.

For future reference, make note of your system hostname.

```bash,run
hostname
```

```nocopy
[[ Instruqt-Var key="newhostname" hostname="rhel" ]]
```

At any time in the future, you can get information about Insights registration by using the `--status` option to `insights-client`.

```bash,run
insights-client --status
```

<pre class=file>
System is registered locally via .registered file. Registered at 2019-08-14T14:12:37.638768
Insights API confirms registration.
</pre>
