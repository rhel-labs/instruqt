---
slug: configure-mysql
id: mucxpwg4sexk
type: challenge
title: Configure MySQL
notes:
- type: text
  contents: Next, you will configure the security settings for your SQL server
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
difficulty: basic
timelimit: 600
---
To begin the security configuration process for your database, run the following command:
```bash
mysql_secure_installation
```

Next, you will be asked by the installer if you wish to enable the `Validate Password` component. For our installation, we will not enable it. To leave the feature disabled, press enter.

After this, you will be asked to enter a root password. For your own SQL server, you should select a secure password. For our lab environment, enter the following password:
```bash
rhel
```

It will then ask you to re-enter your password. Re-enter `rhel` and press enter to continue.

>Note: You will not see your password as you type into the terminal. This is normal and is not an issue.

Now the installer will ask you if you wish to disable anonymous login. In production settings, you should disable it. However, in our lab, we will not disable it. Press enter to skip the disabling of anonymous users.

Next, it will ask if you wish to disable remote root access. Because you will log in as root via remote access in this lab, press enter to leave remote root access intact.

After this, it will ask if you wish to remove the test database. We will not remove it, so press enter to leave it as-is.

Finally, it will ask you if it should reload privilege tables. Type `Y` and then press enter to reload them, which will apply our configuration.