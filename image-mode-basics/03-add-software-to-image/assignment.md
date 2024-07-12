---
slug: add-software-to-image
id: 6qrlk0yyqfwn
type: challenge
title: Add software to image
teaser: Add the vim editor to the image.
notes:
- type: text
  contents: |
    # Goal:

    You will update the software available to the VM.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
- title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: basic
timelimit: 600
---

Click on the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab.

If not already shown, select Containerfile in the list on the right side of the tab.

![](../assets/containerfile_scripteditor.png)

To the end of the `dnf install` line, add `vim`.

![](../assets/containerfile_add_vim.png)

The editor will automatically save changes. Once you see Changes Saved in the upper right, you can return to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab.

Use podman to update the image.
===
With our updated Containerfile, we can re-run the `podman build` command to get an updated image.

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