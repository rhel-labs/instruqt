---
slug: lifecycleenv
id: 6suwlqwbv7jj
type: challenge
title: Manage Lifecycle Environments
teaser: Manage Lifecycle Environments
notes:
- type: text
  contents: Manage Lifecycle Environments
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

## <ins>Create a new lifecycle environment</ins>

The application life cycle is a concept central to Red Hat Satellite 6’s content management functions. The application life cycle defines how a particular system and its software look at a particular stage. For example, an application life cycle might be simple; you might only have a development stage and production stage. In this case the application life cycle might look like this:

- Development
- Production

However, a more complex application life cycle might have further stages, such as a phase for testing or a beta release. This adds extra stages to the application life cycle:

- Development
- Testing
- Beta Release
- Production

To find out more about lifecyce environments, please refer to [Satellite documentation](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/managing_content/creating_an_application_life_cycle_content-management.)

Navigate to the `Lifecycle Environments` menu.

![lifecycle](../assets/lifecycle-environments.png)

Click on `Create Environment Path`.

![envpath](../assets/createenvironment.png)

Create a new environment. We'll call this one `test`. Then click `save` to save it.

![envpath](../assets/newenvironment.png)

The `Lifecycle Environment Paths` menu should look like this.

![lifecycleenvpaths](../assets/envmenuresult.png)
