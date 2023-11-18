---
slug: updateimage
id: cymvoqwv9jdc
type: challenge
title: Update the image on your edge device
teaser: Update image
notes:
- type: text
  contents: Update the image on your edge device.
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: browser
  hostname: webconsole
- title: Red Hat Insights
  type: browser
  hostname: insights
difficulty: basic
---
Now we'll update the image and push the updates out to your edge device.

Go back to the hybrid cloud management console and navigate to the image we created.

1) Click on `Actions`.
2) Select `Create new version`.

![createnewversionimage](../assets/createnewversionimage.png)

In this example we'll add `nginx` to the edge device image.

1) Modify the description
2) Click `Next`.

![updateimageimage1](../assets/updateimageimage1.png)

Click through to the `Additional packages` menu.

1) Add the `nginx` package.
2) Click `Next`.

![addnginx](../assets/addnginx.png)

Finally click `Create image` and wait for the image to be created.

Go to the `Images` menu to view the status of the image building process. Notice that the version number has incremented to `2`.

![imagev2status](../assets/imagev2status.png)

When the image build has completed do the following.

1) Click on the `Systems` menu.
2) Then click on the "kebab" button for the edge device we just installed and click 3) `Update`.

![updatenav](../assets/updatenav.png)

Click `Update Device`.

![updatedevice](../assets/updatesubmenu.png)

Go back to the Web Console for the rhel host. You can watch the update run. It might up to 5 minutes before this process begins.

![updating](../assets/updating.png)

When the edge device completes rebooting,SSH into the edge device from the RHEL terminal and check the running image with the command `rpm-ostree status`.

![newversion](../assets/clinewversion.png)

In the hybrid cloud console, you can see that the edge device is now running version 2 of `image1`.

![runningversion](../assets/runningversion2.png)

You may also want to check if the nginx package is installed by entering  `rpm -qa nginx`.
