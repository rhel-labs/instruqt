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

We'll name this content view `RHEL8`. Click `Save` to save it.
![createcv](../assets/createcv.png)

Add the `BaseOS` and `AppStream` repos. Click `Add Repositories`.

![addrepos](../assets/addrepos.png)

Click `Publish New Version`.

![publish](../assets/publish.png)

Click `Save`.

![save](../assets/save.png)

The content view will proceed to be published.

![publishing](../assets/publishing.png)
