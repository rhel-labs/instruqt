---
slug: challenge
id: ny5syzwwctuy
type: challenge
title: Re-Deployable Podman
notes:
- type: text
  contents: |
    # Have you ever used podman with yaml?

    Nate loves his podman, and talks a lot about how he uses kubernetes compatible yaml with podman to make re-deployable applications hosted on RHEL.  Can you make one of these definitions?  Here are some requirements.

    * Place your yaml file in: `/srv/container-defs/application.yml`
    * Make sure your application is inside of a pod, call the pod `my-app`
    * Make sure that the application is available on port 8080
    * Make the application run the image `registry.access.redhat.com/ubi9/httpd-24` (Note that this httpd container also listens on port 8080)
    * Map the filesystem path `/srv/container-data/my-app/www` to `/var/www/html/` within the container
tabs:
- id: o9nthg94x1o8
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # Have you ever used podman with yaml?

  Nate loves his podman, and talks a lot about how he uses kubernetes compatible yaml with podman to make re-deployable applications hosted on RHEL.  Can you make one of these definitions?  Here are some requirements.

  * Place your yaml file in: `/srv/container-defs/application.yml`
  * Make sure your application is inside of a pod, call the pod `my-app`
  * Make sure that the application is available on port 8080
  * Make the application run the image `registry.access.redhat.com/ubi9/httpd-24` (Note that this httpd container also listens on port 8080)
  * Map the filesystem path `/srv/container-data/my-app/www` to `/var/www/html/` within the container

  >NOTE: The check script will stop and delete any running pods.

