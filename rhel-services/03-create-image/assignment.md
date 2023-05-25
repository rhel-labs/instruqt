---
slug: create-image
id: kmqxquynrr1o
type: challenge
title: Create an image
teaser: Create a custom image with Image Builder
notes:
- type: text
  contents: Now we'll go into Image Builder and create a custom image.
tabs:
- title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
difficulty: basic
---
<!-- markdownlint-disable MD033 MD026-->

Navigate to the Image Builder application:

1) Type `Image Builder` in the search bar.
2) In the `Deploy` card, click `Image Builder`.

![search bar](../assets/imagebuildersearchbar.png)

Click on the `Create image` button.

![create image](../assets/createimagebutton.png)

We'll configure the `Image output`.

1) Select `Red Hat Enterprise Linux (RHEL) 9`.
2) Select `Amazon Web Services`.
3) Click `Next`.

![image output](../assets/imageoutput.png)

Configure the `Target environment`.

1) Select `Use an account configured from Sources`. This selects an AWS account that was preconfigured for this lab.
2) Select the source labelled `RHTE1`.
3) Observe that the `Default Region` and `Associated Account ID` are prefilled.
4) Click on `Next`.

![target env](../assets/targetenvironment.png)

Configure system registration in `Register`.

1) Select `Automatically register and enable advanced capabilities`.
2) Select the activation key `rhte`.
3) Click `Next`.

![register](../assets/registersystems.png)

Accept the default `Automatic partitioning` in `File system configuration` and click `Next`.

![default partitioning](../assets/partitioningdefault.png)

Next we'll add software to the image.

1) In `Available packages` search for, and add the following software:
      - `podman`
      <!-- - `rhc` -->
      - `rhc-worker-playbook`
      <!-- - `ansible-core` -->
2) You may also add any other software you wish.
3) Click `Next`.

![add packages](../assets/addpackages.png)

We'll add some packages from custom repositories.

1) Check off the following `Custom repositories`. The `CustomRepo` repository contains the custom made `ubi-init` RPM which will install a Universal Base Image (ubi) container into your image.

   - `CustomRepo`
   - `EPEL 8 Everything x86_64` or `EPEL 9 Everything x86_64` if you are building a RHEL 9 image.

2) Then click `Next`.

![choose repos](../assets/customreposchecked.png)

Add packages from the custom repositories.

1) Add the following packages.
   - `libyubikey` - This package sits in the EPEL repository.
   - `openvpn` - This package also resides in the EPEL repository.
   - `ubi-init` - This is a custom package residing in the `CustomRepo` repository and contains a ubi container image.

2) Click `Next`.

![add custom software](../assets/selectcustompackages.png)

Give your image a name (something easily idenitfiable by you) and click `Next`.

![name image](../assets/nameimage.png)

Review the configuration and then click `Create image`.

![create image](../assets/createimage.png)

The image build process will take about 15-20 minutes.

![image building](../assets/creatingimage.png)

Proceed to the next step of this lab where you may continue with pre-built images.
