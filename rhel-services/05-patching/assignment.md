---
slug: patching
id: exth6yd9exqt
type: challenge
title: Patching hosts
teaser: Patch hosts through the Red Hat Hybrid Cloud console
notes:
- type: text
  contents: We will apply patches via the Red Hat Hybrid Cloud Console.
tabs:
- title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
- title: Terminal
  type: terminal
  hostname: rhel1
  cmd: tmux attach-session -t "term1"
- title: Notepad
  type: code
  hostname: rhel1
  path: /notes/notepad
difficulty: basic
---
<!-- markdownlint-disable MD033 MD026-->

To demonstrate patching, we'll downgrade `podman` and `bash` before utilizing the patching application.

```bash
dnf -y downgrade bash podman
```

Next we'll run `insights-client` to update the host's metadata status the Red Hat Hybrid Cloud Console.

```bash
insights-client
```

![downgrade](../assets/downgrade.png)
![insights-client](../assets/insights-client.png)

Navigate to the `Systems` menu in the `Patch` application.

![systems patch](../assets/patchsystems.png)

Locate your host in the list, based on its private IP address / hostname.  It should have two installable advisories (which are the packages we just downgraded).

Click on the host.

![patchable](../assets/patchable.png)

You'll be taken to the menu showing the installable advisories.

![advisories](../assets/bugsinhost.png)

We'll upgrade `bash` first.

Click on the `Packages` tab.

![packages](../assets/packagestab.png)

Initiate the remediation by doing the following.

1) Click on the checkbox to select `bash`.
2) Click `Remediate`.

![start remediate](../assets/startremediate.png)

You'll be asked to `Select playbook` next. This feature is designed to enable you to create customized playbooks that include remediations detected from other Insights applications, like `Compliance` for example.

In other words, you may want to upgrade `bash` but then you might also want to remediate other problems detected by OpenSCAP (through the `Compliance` application).

Create a new playbook.

1) Select `Create a new playbook` and give it a name. In this example we'll call it `test-001`.
2) Click `Next`.

Review the correct system is selected and click `Next`.

![review systems](../assets/reviewsystems.png)

Review the remediation and click `Submit`. Note that `Autoreboot` is enabled. This can be turned off if desired.

![submit](../assets/submitremediation.png)

Here's the result. **Do not close this window.**

![submitted](../assets/submitted.png)

Click on `Open playbook test-001`.

![open playbook](../assets/openplaybook.png)

Click on `Execute playbook`

![execute playbook](../assets/executeplaybook.png)

Click on `Execute playbook on 1 system`.

![execute on 1 system](../assets/executetheplaybookforreal.png)

You can view the execution of the remediation playbook in real-time by clicking on `View`.

![view](../assets/viewexecution.png)

<!-- Click on `Direct connected`.

![direct connected](../assets/directconnected.png)

Click on the `>` symbol next to the name of the host.

![execute name](../assets/executename.png)
 -->

In the terminal, you will see the host disconnect the ssh session as it reboots.

You can go back to the patch menu for the host and the bash package will not be listed anymore.

![patched](../assets/patched-bash.png)
