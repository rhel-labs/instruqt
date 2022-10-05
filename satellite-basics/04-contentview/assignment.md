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
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

In this challenge we'll create a Content View. Red Hat Satellite uses Content Views to create customized repositories from the repositories. You can use Content Views to define which software versions a particular environment uses. For example, a Production environment might use a Content View containing older package versions, while a Development environment might use a Content View containing newer package versions.

Since this is a basic introduction to Satellite, we will only create a Content View for the purpose of providing content to RHEL hosts, without regard for Test, Production lifecycle use cases.

To learn more about Content Views and how to use them to manage content for different lifecycle environments, please see [Managing Content Views](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/managing_content/managing_content_views_content-management) in Satellite documentation.

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
