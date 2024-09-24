---
slug: filter-software
id: ggpczlvl6b5b
type: challenge
title: Apply a Content View filter
teaser: Block software from being installed. Without these filters, a Content View
  includes everything from the selected repositories.
notes:
- type: text
  contents: Block software from being installed
tabs:
- id: ohxpa4fpwc9z
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: nlvg8hn2c0fp
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: aeae2miso0w9
  title: rhel1
  type: terminal
  hostname: rhel1
- id: agyhixqdtdps
  title: rhel2
  type: terminal
  hostname: rhel2
difficulty: basic
timelimit: 1
---
Introduction
===
A powerful feature of Content Views in Red Hat Satellite is the ability to filter content. This means that you can include or exclude content from being installed by your hosts. In this challenge, we'll block the installation of emacs with a filter (since it's bloatware).

Go to the Content Views menu.

![cv](../assets/contentview.png)

Click on the `RHEL9` content view.

![rhel9](../assets/rhel9cv.png)

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

Click `Publish new version` to publish a new version of the `RHEL9` content view containing our new `emacs` filter.

![filter pub](../assets/publishcvfilter.png)

The new content view will make `emacs` unavailable for hosts to install.

1) Add a description to the content view version. In this case, `added emacs filter`.

2) Select `Promote`.

3) Select the `Test` lifecycle environment.

4) Click `Next`.

![publish](../assets/publishfiltercv.png)

Ensure the details of this new version are correct and then click `Finish`. Make sure to wait for the content view to finish publishing or else the filter won't work properly.
> [!WARNING]
> It can take up to 5 minutes for this particular task to complete publishing the content view.

Next, click on one of these buttons for [button label="rhel1"](tab-2) **or** [button label="rhel2"](tab-3) and run the following command.

```bash,run
dnf install -y emacs
```

![emacs blocked](../assets/emacsinstallerror.png)

Now all your users will be forced to use vim.
