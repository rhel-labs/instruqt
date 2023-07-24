---
slug: login
id: ptrlnjxwtjcx
type: challenge
title: Log in to the Web Console
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
## Log in to the Web Console

Click on the tab titled **RHEL Web Console** at the top of  your lab system interface. Selecting this tab will open the lab system's Web Console in a
new browser tab or window.

![web console](../assets/pop-out-2.png)

Click `Advanced`

![Connection not private](../assets/connection-not-private.png)

Then click `Proceed to rhel.xxxx.instruqt.io`

![Proceed](../assets/proceed.png)

Once the login page is presented, use the following credentials to log into the Web Console:

1 - Username:

```bash
rhel
```

2 - Password:

```bash
redhat
```

![Web Console Login](../assets/Web-console-login.png)

Now that you are logged into the Web Console, we must turn on administrative access.

Click `Turn on administrative access`.

![admin access](../assets/turn-on-admin.png)

Next do the following:

1) Enter the password: **redhat**
2) Click `Authenticate`

![auth](../assets/auth.png)

## Navigate to Image Builder application

After logging into the Web Console, you'll be looking at the Overview tab. Navigate to the Image Builder tab, as shown below:

![Navigate to Image Builder](../assets/Nav-ImageBuilder.png)

Because you have not used Image Builder before, you will need to start the back-end service by clicking the *Start* button.

![Start Image Builder Service](../assets/ImageBuilder-start-service.png)

Now that the back-end service has been started, you will notice that the application screen updates and you can now *Create Blueprint*, which is what you will do on the next step.
