---
slug: add-software-to-image
id: s4w4aucc2mdx
type: challenge
title: Add software to image
teaser: Add the vim editor to the image.
notes:
- type: text
  contents: |
    # Goal:

    Providing updates and software changes to a host is part of the standard life cycle. It can be even more common during the design part of our standard operating environments. This process is where image mode hosts deviate the most from typical package based hosts.

    In this exercise, we'll explore how to make changes in images for our hosts to use.
tabs:
- id: bo1ice7w6ghm
  title: Terminal
  type: terminal
  hostname: rhel
- id: z0usor0xuc5s
  title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
difficulty: basic
timelimit: 600
enhanced_loading: null
---

Click on the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab.

If not already shown, select Containerfile in the list on the right side of the tab.

![](../assets/containerfile_scripteditor.png)

Sofware is controlled via the Containerfile. To change or add packages, they need to be defined here before build time. Updating already built images with later versions would only need a rebuild.

To the end of the `dnf install` line, add `vim` to the list of packages installed.

![](../assets/containerfile_add_vim.png)

The editor will automatically save changes. Once you see Changes Saved in the upper right, you can return to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab.

Use podman to update the image.
===
With our changes in the Containerfile, we can re-run the `podman build` command to get an updated image.

```bash,run
podman build -t [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc .
```

Since the `RUN` command to install software happens after the `ADD` command to install config files, notice `podman` used the cached layer rather than rebuilding it. Layer caching and ordering can be a powerful tool when designing and updating standard operating builds.


Push the image to the registry
===

Once the updated image has been built, we can push it to the registry. Once again, note how only the changed layers need to be added to the registry.

```bash,run
podman push [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc
```

In the next step, we'll look at how to update a running system from the new image we just pushed to the registry.
