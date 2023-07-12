---
slug: filter-software
id: pyfrqycbe9zt
type: challenge
title: Apply a Content View filter.
teaser: Block software from being installed. Without these filters, a Content View
  includes everything from the selected repositories.
notes:
- type: text
  contents: Block software from being installed
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

Go to the Content Views menu.

![cv](../assets/contentview.png)

Do the following.

1) Click on the `Filters` tab.
2) Click `Create filter`.

![filter](../assets/filter.png)

Create a filter with the following steps.

1) Name the filter `emacs`.
2) Select `Exclude filter`.
3) Give the filter a description. We're going to exclude emacs from being included in the `RHEL9` content view.
4) Click `Create filter`.

![create filter](../assets/createfilter.png)

Next, click `Add RPM rule`.

![emacs](../assets/emacsrpmrule.png)

Configure your RPM rule in the following way.

1) Since we're filtering `emacs`, enter `emacs`.
2) Select `All versions`.
3) Click `Add rule`.

![add rpm rule](../assets/addrpmruleemacs.png)

Click `Publish new version` to publish a new version of the `RHEL9` content view containing our new `emacs` filter. The new content view will make `emacs` unavailable for hosts to install.

1) Add a description to the content view version. In this case, `added emacs filter`.
2) Select `Promote`.
3) Select the `Test` lifecycle environment.
4) Click `Next`.

![publish](../assets/publishfiltercv.png)

Ensure the details of this new version are correct and then click `Finish`.

Next, go into the terminal of one of the hosts and enter the following.

```bash
dnf install -y emacs
```

![emacs blocked](../assets/emacsinstallerror.png)

Now all your users will be forced to use vim.
