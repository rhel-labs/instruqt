---
slug: step2
id: eco0rlrenhyz
type: challenge
title: Upload a manifest to the Satellite server.
teaser: Upload a manifest to the Satellite server.
notes:
- type: text
  contents: Upload a manifest to the Satellite server.
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
timelimit: 2400
---
<!-- markdownlint-disable MD033 -->

## <ins>Log into the Satellite Web UI</ins>

If you haven't done so, log into the Satellite Web UI.

Username:

```bash
satadmin
```

Password:

```bash
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

## <ins>Upload a manifest</ins>

A subscription manifest contains a list of the subscriptions, products, and content repositories entitled to an organization. The manifest must be obtained from the customer portal at access.redhat.com. For more information, please read the article.

<https://access.redhat.com/solutions/118573>

For this lab, we have created a manifest for you.

Click on `Subscriptions` within the following sub-menu show below.

![subscriptions](../assets/subscriptions.png)

Next, click on the button labelled `Import a manifest`.

![importmanifest](../assets/import-a-manifest.png)

Click on the button labelled `Choose File`.

![choosefile](../assets/choose-file.png)

Select your manifest file to upload it to the Satellite server.

You'll see a progress bar showing the progress import operation.

![progressimport](../assets/importing.png)
