---
slug: syncrepos
id: ldbnzx1qymok
type: challenge
title: Synchronize Red Hat repositories
teaser: Synchronize Red Hat repositories
notes:
- type: text
  contents: In this step, we'll synchronize Red Hat Enterprise Linux 9 BaseOS and
    AppStream repositories from the content delivery network.
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
## <ins>Synchronize repositories</ins>

Navigate to the Red Hat Repositories menu by clicking on `Red Hat Repositories` in the menu context below.

![](../assets/redhatrepositories.png)

The Red Hat Repositories menu will provide a list of available repositories. You can choose to synchronize whatever you want. In this lab we'll synchronize the `BaseOS` and `AppStream` repos for RHEL 9.

Red Hat Enterprise Linux 9 is distributed through two main repositories:

* BaseOS
* AppStream

Both repositories are required for a basic RHEL installation, and are available with all RHEL subscriptions.

Content in the BaseOS repository provides the core set of the underlying OS functionality that provides the foundation for all installations. This content is available in the RPM format and is subject to support terms similar to those in previous releases of RHEL. For more information, see the Scope of Coverage Details document.

Content in the AppStream repository includes additional user-space applications, runtime languages, and databases in support of the varied workloads and use cases.

<h1>Note: In order to save time, the BaseOS and AppStream repositories have been enabled.</h1>

Click on the `Recommended Repositories` button to create a more succinct view of available repos (the image below displays the button in the off position; turn it on).

![recommanded repos button](../assets/recommendedrepos.png)

Here's what it looks like to add the BaseOS and AppStream repos.

![addedrecommended repos](../assets/addedrecommendedrepos.png)

And here's an animation.

![](../assets/2022-08-11_09-02-27.gif)

Next, we'll navigate to the `Products` menu.

![](../assets/products.png)

Select the required product (in this case `Red Hat Enterprise Linux for x86_64`) and click `Sync Selected`.

![](../assets/synchronize.png)

To view the status of the sync operation, click on `Sync Status`.

![](../assets/syncstatus.png)

Expand the menu widgets to see a detailed report on the sync status.

![](../assets/syncstatusdetailed.png)

>_NOTE:_ The BaseOS and AppStream repos take approximately 5 minutes to synchronize.
