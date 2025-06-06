---
slug: lifecycleenv
id: znmfukglz7mx
type: challenge
title: Manage Lifecycle Environments
teaser: Manage Lifecycle Environments
notes:
- type: text
  contents: Satellite provides methods to customize each application life cycle stage
    so that it suits your specifications. Each stage in the application life cycle
    is called an environment in Satellite.
tabs:
- id: r8261eq2bbul
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: 3iesqhl5avlc
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: bqrdcxft3syc
  title: rhel1
  type: terminal
  hostname: rhel1
- id: auurwswp2uiv
  title: rhel2
  type: terminal
  hostname: rhel2
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Introduction
===

The application lifecycle is a concept central to Red Hat Satellite 6’s content management functions. The application lifecycle defines how a particular system and its software look at a particular stage. For example, an application lifecycle might be simple; you might only have a development stage and production stage. In this case the application lifecycle might look like this:

- Development
- Production

However, a more complex application life cycle might have further stages, such as a phase for testing or a beta release. This adds extra stages to the application life cycle:

- Development
- Testing
- Beta release
- Production

To find out more about lifecycle environments, please refer to [Satellite documentation](https://access.redhat.com/documentation/fr-fr/red_hat_satellite/6.15/html/managing_content/managing_application_lifecycles_content-management).

Create a lifecycle environment
===
Navigate to the `Lifecycle Environments` menu.

![](../assets/lifecycle-environments.png)

Click on `Create Environment Path`.

![](../assets/createenvironment.png)

Create a new environment. We'll call this one `Test`. Then click `save` to save it.

![](../assets/newenvironment.png)

The `Lifecycle Environment Paths` menu should look like this.

![](../assets/envmenuresult.png)
