---
slug: gui-container-management
id: uohlyzjr7tw4
type: challenge
title: Creating Containers in the Web Console
notes:
- type: text
  contents: In this step, you will configure Podman containers through the RHEL web
    console. This gives you a graphical view of your containers and can help simplify
    container configuration.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 600
---
In this lab, you will install Grafana, a browser-based data dashboard, in two ways. First, you will install and run it through the RHEL web console. After that, you will install and configure the Grafana container through Podman's command line interface (CLI). The RHEL web console gives you a graphical view of your containers and can help you customize your containers more simply.

First, click on the `RHEL Web Console` tab.
![](../assets/pop-out-2.png)
Next, log in with the following credentials:
>* Username: rhel
>* Password: redhat
![](../assets/Web-console-login.png)

After logging in, click on the button in the web console labeled `Enable administrative access`.
![](../assets/turn-on-admin.png)

Next, enter the password (`redhat`) and click `Authenticate`
![](../assets/auth.png)

In the menu on the left side of the web console, select `Podman containers`
![](../assets/podman_containers_button.png)

From here, you can manage [containers and pods](https://developers.redhat.com/blog/2019/01/15/podman-managing-containers-pods). Click `Create container` to create your Grafana container.
![](../assets/create_container_button.png)

In the `Details` tab of the `Create container` dialog, enter the following details:
* Name: Grafana
* Image: docker.io/grafana/grafana
![](../assets/grafana_details_tab.png)
Next, click on the `Integration tab`, select `Add port mapping`, enter 3000 as the value for `Host port`, enter 3000 as the value for `Container port`, and then select `Create and run`.
![](../assets/grafana_integration_tab.png)

Wait about 30 seconds for the container to run. You may need to refresh the page to update the container status. Once the container state is `running`, proceed to the next step.