---
slug: rollback-a-host
id: ii7woss9bdxe
type: challenge
title: Rolling back software updates
teaser: Roll back changes to a deployed host
notes:
- type: text
  contents: |
    # Goal:

    Recovering from software problems is typically an expensive proposition that requires a lot of preparatory work. Operating in image mode, roll back is a native capability.

    In this exercise, we'll explore how to revert to an earlier image already on disk.
tabs:
- id: zje6jrqczgve
  title: Terminal
  type: terminal
  hostname: rhel
- id: tpkjptwwk0eu
  title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
- id: fzmfm00uw2yp
  title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: basic
timelimit: 1
---
> [!NOTE]
> You should still be in the VM Console tab. If not,
> Click on the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-2) tab.
> You may need to tap `enter` to wake up the console, you should still be logged in as `core`

Image mode systems have a native capability that typically takes more preparation with package mode operations: the rollback.

Since `bootc` unpacks images locally, we still have the previous version of the host on disk. Our `v2` image was unpacked along side of the original image, then the set as the primary target in the bootloader. To restore the previous version of a package mode system, we’d need to have set up snapshots before changes were made or refer to a backup. With `bootc` we have a single command that can revert to the last booted image.

A missing web page isn't the sort of issue we'd normally need to recover from a backup, but this is a lab after all. Let's go ahead and check for an available rollback option to get us back to the previous image.

```bash,run
sudo bootc status | grep rollback: -A 8
```

This section of the status output shows the available image target. You should see our original image, without the `v2` tag. To trigger the rollback, we issue one command.
```bash,run
sudo bootc rollback
```

The command should return very fast and the output looks like this:
````
bootfs is sufficient for calculated new size: 0 bytes
Next boot: rollback deployment
````

There are two additional places in the status you can look for information about what will happen at the next boot. You should see the value of `rollbackQueued` has been updated. This can be useful to check before restarting a sysytem.
```bash,run
sudo bootc status | grep Queued
```

````
rollbackQueued: true
````

You can also check the boot order in the spec block to see what has been sent to the bootloader. This should match one of `default` or `rollback`. The `default` order will use the image from the `spec` section of the status.
```bash,run
sudo bootc status | grep Order
```

````
bootOrder: rollback
````
Feel free to explore `bootc status` further before moving on.

As usual, a reboot is needed to apply changes. After the reboot, the rollback image will become the booted image, and will also become the new default in the boot order.
```bash,run
sudo reboot
```

While the system reboots and returns to the previous state, let's dig into what happened in the Containerfile and explore why our index.html update didn't go the way we expected.