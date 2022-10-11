---
slug: syncrepos
id: ldbnzx1qymok
type: challenge
title: Synchronize Red Hat repositories
teaser: Synchronize Red Hat repositories
notes:
- type: text
  contents: In this step, we'll synchronize content from Red Hat repositories.
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

![rhrepos](../assets/redhatrepositories.png)

The Red Hat Repositories menu will provide a list of available repositories. You can choose to synchronize whatever you want. In this lab we'll synchronize the `BaseOS` and `AppStream` repos for RHEL 9.

Red Hat Enterprise Linux 9 is distributed through two main repositories:

* BaseOS
* AppStream

Both repositories are required for a basic RHEL installation, and are available with all RHEL subscriptions.

Content in the BaseOS repository is intended to provide the core set of the underlying OS functionality that provides the foundation for all installations. This content is available in the RPM format and is subject to support terms similar to those in previous releases of RHEL. For more information, see the Scope of Coverage Details document.

Content in the AppStream repository includes additional user-space applications, runtime languages, and databases in support of the varied workloads and use cases.

Click on the `Recommended Repositories` button to create a more succinct view of available repos.

![baseosappstreamrepos](../assets/2022-08-11_09-02-27.gif)

Next, we'll navigate to the `Products` menu.

![products](../assets/products.png)

Select the required product (in this case `Red Hat Enterprise Linux for x86_64`) and click `Sync Selected`.

![sync](../assets/synchronize.png)

To view the status of the sync operation, click on `Sync Status`.

![syncstatus](../assets/syncstatus.png)

Expand the menu widgets to see a detailed report on the sync status.

![syncstatusdetailed](../assets/syncstatusdetailed.png)

>_NOTE:_ The BaseOS and AppStream repos take approximately 5 minutes to synchronize.
