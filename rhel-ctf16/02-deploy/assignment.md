---
slug: deploy
id: jdx5a6ypeujr
type: challenge
title: Deploying production
notes:
- type: text
  contents: |-
    You were at lunch and we decided to launch now, so I went ahead and just deployed it for you.

    You're welcome.

    - Manager Scott
tabs:
- id: mfsv4htjy6ig
  title: Build host
  type: terminal
  hostname: builder
  cmd: /bin/bash
- id: 2boyxmnln8sp
  title: Webserver
  type: terminal
  hostname: builder
  cmd: ssh webserver
- id: ftcqbnqecfra
  title: Production website
  type: service
  hostname: webserver
  port: 80
  new_window: true
difficulty: ""
enhanced_loading: null
---
Manager Scott says "Well that image is broken, so you need to get the website back now before doing anything else!"

# Goal

The new website is blank except for the footer!

Get the old website on the image mode host back up and running.

Click *Check* when you think it's ready