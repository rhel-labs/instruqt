---
slug: upgrade
id: 9zgonkvlagao
type: challenge
title: Build the new image
notes:
- type: text
  contents: |
    The development team heard all about RHEL 10 and want to look at it running the website. They'll need to test any changes and want to deploy the website just like it is today but on RHEL 10.

    Oh, and we don't have any free systems or VMs to deploy on. Figure it out.
    - Manager Scott

    # Goal

    Update an image mode host with a RHEL 10 version of an existing image to give the developers a way to start their testing.
tabs:
- id: ctwocxk9fzrb
  title: Production website
  type: service
  hostname: webserver
  port: 80
  new_window: true
- id: 2vfabwszif6k
  title: Build host
  type: terminal
  hostname: builder
  cmd: /bin/bash
- id: zd4ncincycce
  title: Webserver
  type: terminal
  hostname: builder
  cmd: ssh webserver
difficulty: ""
timelimit: 0
enhanced_loading: null
---
The development team heard all about RHEL 10 and want to look at it running the website. They'll need to test any changes and want to deploy the website just like it is today but on RHEL 10. Make sure we can tell the new image apart from the production images so we don't deploy the wrong one.

# Goal

Change an image mode host to use a RHEL 10 version of the current RHEL 9 image to give the development team a way to start testing.

Use a new tag or name for the test image

The website should have an updated footer, but otherwise be the same