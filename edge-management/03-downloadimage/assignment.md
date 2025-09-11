---
slug: downloadimage
id: zabuwrgcpsfj
type: challenge
title: Download image to RHEL Host
teaser: Download image to RHEL Host
notes:
- type: text
  contents: Download your new OS image.
tabs:
- id: embgrcnflb3r
  title: rhel
  type: terminal
  hostname: rhel
- id: dezlivxmmpjt
  title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Now that the image has been created, we'll download it to the RHEL host in the lab so that we can install it in a VM (which we can consider to be our edge device).

Click on the image we just created.

![newlycreatediamge](../assets/clickonimage.png)

1) On the image menu click on `Actions`.
2) Right-click on `Download installable .iso for newest image`.
3) Click on `Copy link address`.

![geturl](../assets/geturl.png)

Click the `rhel` tab in the Instruqt lab webpage.

![rheltab](../assets/rheltab.png)

Change into the `images` directory.

```bash
cd /images
```

Due to the limitations of the lab environment, you will download the edge install iso with a specially created script.

Enter the following command.

```bash
./dl_edge_iso "<copied URL>"
```

The image download will begin.

![downloadprogress](../assets/downloadprogress.png)

Check that the image is located in the directory `/images`.

![verifydownloaded](../assets/verifydownloaded.png)
