---
slug: challenge
id: jutpaux94fez
type: challenge
title: Containerize the web site
notes:
- type: text
  contents: |
    # Put this site in a container

    Can you build a container?  Here are your requirements.

    * In /srv/app you will find a basic PHP web site
    * Build a container that serves that site
    * Make it listen on port 8000
    * Run the container in podman as the existing non-root user `webuser`
tabs:
- id: zzrdwmu8pyvb
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # Put this site in a container

  Can you build a container?  Here are your requirements.

  * In /srv/app you will find a basic PHP web site
  * Build a container that serves that site
  * Make it listen on port 8000
  * Run the container in podman as the non-root user `webuser`