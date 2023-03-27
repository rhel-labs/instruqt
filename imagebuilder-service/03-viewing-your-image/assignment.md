---
slug: viewing-your-image
id: xxfpnnxb2i3v
type: challenge
title: Viewing your downloaded image
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
difficulty: basic
timelimit: 1
---
In the tab labelled `Terminal` you should find a RHEL 9 system.  On that system, in your home directory, there is a disk image named:

```bash
composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2
```

This image was built using the Image Builder service, using the same instructions that you just performed in this lab, and then pre-downloaded for the purposes of the next exercise. 

Using the `file` command line utility shows us that the resulting image is a QEMU qcow2 disk image.

```bash
file composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2
```
`composer-api-ee3492f7-5d95-4c1b-a223-bbf04b9adef4-disk.qcow2: QEMU QCOW2 Image (v3), 18991808512 bytes`

At this point, you could take this image and run a VM from it, or upload it to your custom images on your cloud provider. But first we're going to make some changes to it.
