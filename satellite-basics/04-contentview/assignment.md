---
slug: contentview
id: oc82d5c9dbrs
type: challenge
title: Create a content view
teaser: Create a content view
notes:
- type: text
  contents: Create a content view.
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

Click on `Content Views`.

![contentview](../assets/contentview.png)

Click on `Create New View`.
![createnewview](../assets/createcontentview.png)

We'll name this content view `RHEL9`. Click `Create content view` to save it.

> **NOTE:** Please ensure that you type `RHEL9` in capital letters. We'll need this value in step 6 of this lab.

![createcv](../assets/createcv.png)

Add the `BaseOS` and `AppStream` repos. Click `Add Repositories`.

![addrepos](../assets/addrepos.png)

Click `Publish New Version`.

![publish](../assets/publish.png)

Next we'll complete the following steps to publish and promote the content view.

1) Click the sliding `Promote` button.
2) Select the lifecycle environment you wish to promote the content view to. In this case it is `Test`.
3) Click `Next` to review the task.

![publishing wizard](../assets/publishwizard.png)

Review the details and then click `Finish`.
