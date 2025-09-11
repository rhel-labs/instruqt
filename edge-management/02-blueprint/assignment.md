---
slug: blueprint
id: 7czvpzalyypu
type: challenge
title: Create an Image
teaser: Create an OS image for your Edge Device
notes:
- type: text
  contents: Create an OS image for your Edge Device.
tabs:
- id: i4vbooer2omn
  title: rhel
  type: terminal
  hostname: rhel
- id: egeqoq8dsqwo
  title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---
We'll create an operating system image to install on our edge device.

Navigate to the `Images` menu.

![image](../assets/images-menu.png)

Click `Create new image`.

![create new image](../assets/createnewimage.png)

1) Give your image a name.
2) Enter a description
3) Click `Next`.

![details](../assets/imagedetails.png)

1) Ensure the Red Hat Enterprise Linux (RHEL) 9 is selected.
2) Make sure RHEL for Edge Installer (.iso) is checked.
3) Click `Next`.

![options](../assets/rhel9image.png)

Use the following credentials for logging into the edge device.

Username

```bash
rhel
```

Public SSH key

```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfGPDGOejzTPeRoQNIv88ThRHhjc8y97bdsPmnfn9CQCGh9EYhklDiHlvDwMs3euPd0408atlhYKSkoLefHFeXEtMKdZuhPKN2OhpDREXLkLS3PP7PbsELEzHXGKy25aj9z3Jo6LeGJoycoA40xs3oG60OUAMhRUNXBs52WvL1ZU142FxDqxzwy0uLwh4PNFRLDGpMVd/fdl1sVML6ZT2Fe820ewlTzh3X8J5EcDt/uDPHL8SsHVllt5SoATBGUJj5T0ZPsRyOFvy8+q/JRW2No+siAch2MXMRlf2wmBRurOj06eQ3icQCU8zL40xIWBJOPD2FPymnrPX6rulg55+ozFSTddl2BOprVWZE5yQrhRSr5ryJgc6o5nMnT0DnWexNeSv2OLdGvsfhvaa0ZETztyJOAJEG7xXr7HoXkFQcuo2q0Q1mATXadQtITxMjI4LjOroIVnLO+KzIiShOip4Jp8fFRwCWdiwo/X9PwFnR5mPPwR7Qdoa5jJSPNE8Ehea2Ev2isL/uHm6byqKW/m/3SEiIwkzljhacCNxssHi3HXCdLaJVhmOjRAtQxvrF/sVuPoyVEhN5X48wkh1WpIM7jDUlf8rpTg1sw8r4m2x6GFQm/VoXL4Eui4qBiG0IeQ8+CrYTu2yhi7besVc/vexNB5W8+7rpEOlVnV2uFW4YyQ==
```

![devicereg](../assets/devicereg.png)

Click `Next`.

Skip the custom repositories.

![customrepo](../assets/customrepos.png)

In the `Additional packages` menu, add `tmux` and `vim-enhanced` to the image.

![additional_packages](../assets/additionalpackages.png)

Click `Next`.

Click `Create image`.

![createimagefinal](../assets/createimage2.png)

The image creation process will take about 15 minutes to complete. Refresh this page to update the status.

![imagecreationstatus](../assets/imagecreationstatus.png)
