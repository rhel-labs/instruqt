---
slug: configure-custom-repos
id: oundo1crif08
type: challenge
title: Configure custom repositories.
teaser: Configure custom repositories containing custom software.
notes:
- type: text
  contents: |-
    In this challenge, we'll orient ourselves with the configuration of custom repositories to add third party software to your image.
    This feature makes it easy to add software without having to manually install it after provisioning the virtual machine.
tabs:
- title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
difficulty: basic
---
<!-- markdownlint-disable MD033 MD026-->

In this challenge we'll show you how to configure custom repositories. Custom repositories may be used to inject third party or custom RPMs into images built with the Image builder application. This challenge is optional as we will provide pre-configured custom repositories to be used later in this lab.

Let's navigate to the repositories menu.

Click on the `Settings gear` and click on `Settings`.

![settings gear](../assets/settingsgear.jpg)

Click on `Repositories`

![repos menu](../assets/repositories.png)

There are a few pre-configured repos.

_**At this point, you may add a custom repository or proceed to the next step.**_

![repos](../assets/configuredrepos.png)

If you would like to configure a custom repo, click on `Add repositories` and fill in the wizard below.

![add custom repo](../assets/addcustomrepo.png)
