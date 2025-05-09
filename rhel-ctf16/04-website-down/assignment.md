---
slug: website-down
id: wlpzbzphj9z6
type: challenge
title: Fix production
teaser: Well that update was broken and I don't know what's wrong, fix it and get
  an update ready.
tabs:
- id: xo2exjpx7lfi
  title: Build host
  type: terminal
  hostname: builder
  cmd: /bin/bash
- id: qyvuco7e85lr
  title: Webserver
  type: terminal
  hostname: builder
  cmd: ssh webserver
- id: 5patxcewoe5e
  title: Production website
  type: service
  hostname: webserver
  port: 80
  new_window: true
difficulty: ""
enhanced_loading: null
---
Now that the site is back online, the deployment has been unzipped on the build host.

# Goal
Figure out what went wrong with the new site from the development team and fix it.

Then stage the new image on the web server so we'll be ready for the next maintenance window, once we get one.

Just **don't reboot the webserver again** during business hours...

Click *Check* to notify Manager Scott the webserver is ready.