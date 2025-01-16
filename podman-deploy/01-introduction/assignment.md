---
slug: introduction
id: 5tlom6jx9cfp
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to deploy and control an already defined container image.

    # Concepts included in this scenario:
    * List available container images
    * Deploy a container image into an interactive container runtime
    * Deploy a container image into a detached container runtime
    * View deployed containers
    * Stop a container instances
    * Remove deployed container instances

    # Example Usecase:
    You have been asked to deploy a container running a web based application onto a server in your environment.  In addition to deploying it, you need to be able to start alternate copies and remove any non-running containers.

    # Lab Feedback
    If you would like to report any bugs or make suggestions on how we can improve our labs, [please leave us a message here](https://github.com/rhel-labs/instruqt/discussions/categories/general).

    # YouTube
    For more information about Red Hat Enterprise Linux, we invite you to view our [YouTube channel]([**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)). [**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)

    If you are interested in learning critical administration skills for Red Hat Enterprise Linux, you might be interested in our show [Into the Terminal](https://www.youtube.com/playlist?list=PLXJyD2dL4oqeX-C3MvsMUJuEzWM4vLK2C).

    Here are our [playlists](https://www.youtube.com/@RedHatEnterpriseLinux/playlists). You can find various playlists on topics such as product updates and Satellite configuration and administration.

    # Reddit
    Come find us on Reddit at r/redhat.
    https://www.reddit.com/r/redhat/
tabs:
- id: 1kndnh9ylor7
  title: Podman
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "podman" > /dev/null 2>&1
- id: s6m8smj5z7g3
  title: RHEL Host
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "host" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
In this lab we have two terminals to make navigation easier. The `Podman` terminal will be used for podman related tasks. The `RHEL Host` tab will be used for host related tasks.

![nav tabs](../assets/navtabs.png)

Click on the `Podman` tab.

Enter the following command to view the existing images on the RHEL host.

```bash,run
podman images
```

<pre class=file>
REPOSITORY              TAG      IMAGE ID       CREATED        SIZE
localhost/rhel9-httpd   latest   c12e3720df7b   43 hours ago   499 MB

</pre>

There is one container available in the local (localhost) repository,
__rhel9-httpd__.  If there were multiple updated iterations of the conatiner
available, you would use the __IMAGE ID__ to work with those that are not
tagged as __latest__.  Also, from this list you are able to see the size, on
disk, of the container image.
