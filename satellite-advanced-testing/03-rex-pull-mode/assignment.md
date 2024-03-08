---
slug: rex-pull-mode
id: 6m6r8l7r47ky
type: challenge
title: Configure Remote Execution (REX) Pull Mode
teaser: Learn how to configure remote execution pull mode and how to migrate hosts
  to it.
notes:
- type: text
  contents: Configure Remote Execution pull mode.
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
difficulty: ""
---
Since Satellite 6.12, Remote Execution or REX has provided the option of a "pull mode". Remote execution pull mode uses Message Queuing Telemetry Transport (MQTT) to publish jobs on Capsule servers (or Capsule service running on a Satellite server). Managed hosts subscribe to the MQTT broker to receive REX job notifications.

Here’s how REX Pull mode works:

1) A managed host receives MQTT notification that there is a new REX job.
2) The managed host downloads the job “payload” via HTTPS from the Capsule service (in this lab the capsule service is running on the Satellite server itself).
3) The job “payload” is run on the host. As the job executes, the progress of the job is reported back to the Capsule service.

Here are the configuration considerations:

1) Port 1883 (MQTT) must be opened on the Satellite server running the Capsule service to allow incoming traffic, and the host must be allowed to connect to the Capsule server on port 443 (HTTPS) to enable REX pull mode.
2) Capsule servers (and Capsule services) must be configured to support either REX push mode or REX pull mode. You cannot configure a Capsule to support both REX modes.
3) For existing hosts running the katello agent, you can migrate to REX pull mode by installing the katello-pull-transport-migrate package. Documentation is provided at the bottom of this post. The katello agent has been deprecated as of Satellite 6.7.

Katello Agent is removed from Satellite 6.15.

Register the host `rhel1` to the Satellite server
=================================================

We'll register the host `rhel1` to our Satellite server using the command line interface to generate a registration command in this lab. The host `rhel1` will be configured to use REX in push mode, giving us the opportunity to migrate it to pull mode.

It is also possible to generate a registration command from the Satellite WebUI but due to the limitations of DNS in this lab environment, we'll use the cli utility `hammer` to simplify the process.

Click on the `Satellite Server` tab.

![satellite server tab](../assets/satellite-server-tab.png)

Copy and paste the following command into the terminal.

```
hammer host-registration generate-command --insecure 1 --setup-insights 0 --force 1 --activation-key RHEL9
```
The output of this command is a curl command similar to this (don't copy paste this):

`curl -sS --insecure 'https://satellite.lab/register?force=true&hostgroup_id=1&setup_insights=false' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJpYXQiOjE2ODI2MjkyNzcsImp0aSI6ImQ1YjFkYThmYzM4OGY5ZjY0MmEyZjc0ZGFhNjRkMmZjODVmZDhiNjU1Y2E3NmM3ODEyYWQ5ZjQzNWE0NWE5Y2UiLCJleHAiOjE2ODI2NDM2NzcsInNjb3BlIjoicmVnaXN0cmF0aW9uI2dsb2JhbCByZWdpc3RyYXRpb24jaG9zdCJ9.bgS1XqSYd4bsY46Suq7QqC5OSKm3bSsN57c3lddiOkU' | bash`

Copy the output by highlighting the selected text. Once the primary click mouse, button is released, the text will be automatically saved to the clipboard.

![copy paste](../assets/copypaste.gif)

Right click and select paste to paste the command into the `rhel1` terminal. Finally type enter to execute the registration command.

![copy paste rhel1](../assets/registrationrhel1.gif)

Enable pull mode on the Satellite server
========================================

In the `Satellite Server` terminal, run the following command.

```
satellite-installer --foreman-proxy-plugin-remote-execution-script-mode pull-mqtt
```

Open required firewall ports on the Satellite server
====================================================

Open the required firewall ports with the following command in the `Satellite Server` tab.

```
firewall-cmd --permanent --add-port="1883/tcp" && firewall-cmd --reload
```

__Note:__ There is currently no support for changing this port to a different port.

Configure jobs to be sent through the capsule service that the host was registered to
=====================================================================================

The following setting enables hosts to receive REX jobs through the satellite or capsule server they were registered through.

Copy and run this in the `Satellite Server` terminal.

```
tee ~/rexsetting.yml << EOF
---
- name: Configure Satellite 6.14
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Set REX preferred through registered server."
    redhat.satellite.setting:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      name: "remote_execution_prefer_registered_through_proxy"
      value: "true"
EOF
```

Run the playbook.
```
ansible-playbook rexsetting.yml
```

Migrate the `rhel1` host to REX pull mode
=========================================

At the beginning of this assignment, we registered the host `rhel1` to use REX in "push" mode. We'll now migrate it to "pull" mode.

Go to the terminal of `rhel1` and install `katello-pull-transport-migrate` by running the following command.

```
dnf install katello-pull-transport-migrate -y
```

__Please note:__ The `katello-pull-transport-migrate` package is provided by the `satellite-client-6-for-rhel-9-x86_64-rpms` repository. This repo was added to the satellite server and enabled by the activation key in the second task of this lab.

Check that the MQTT agent `yggdrasild` is running.

```
systemctl status yggdrasild
```

The output should look like the screenshot below.

![yggdrasild service](../assets/yggdrasildservicestatus.png)

Test out REX pull mode
======================

Now we'll run a test to confirm that REX pull mode is working. On `rhel1`, run the following command to tail the `messages` log file.

```
tail -f /var/log/messages
```

Now go into the Satellite Web UI and navigate to `All hosts`.

![all hosts](../assets/allhosts.png)

Click the checkbox for `rhel1`.

![rhel1](../assets/selectrhel1.png)

Schedule a remote job for `rhel1`.

![schedule](../assets/schedulerhel1.png)

In the `Category and template menu`, don't change any parameters and click next.

![cat](../assets/categoryandtemplate.png)

In the `Target hosts and inputs menu` do the following:
1) Enter `uname -a` in the `command` box.
2) Click `Run on selected hosts`.

![target](../assets/targethostsandinputs.png)

The REX pull mode job will execute. Once the `Results` menu shows 100%, click on the `rhel1` tab.

The `messages` log file should display something similar to this.

![ygg successful](../assets/successfulyggdrasild.png)

Configure Satellite to automatically configure REX pull mode when registering new hosts
=======================================================================================

At present, Satellite will register hosts in REX push mode by default. We'll need to set a new Global Parameter to enable pull mode by default, with a global parameter. In the `Satellite Server` terminal, enter the following command.

```
tee ~/rexdefault.yml << EOF
---
- name: Configure Satellite 6.14
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Set global parameter to default REX pull mode."
    redhat.satellite.global_parameter:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      name: "host_registration_remote_execution_pull"
      value: "true"
      parameter_type: boolean
      state: present
EOF
```

Run the playbook in the `Satellite Server` terminal.
```
ansible-playbook rexdefault.yml
```

This playbook creates a global parameter `host_registration_remote_execution_pull` with the value of `true`.

You can check to see this parameter was successfully created by navigating to the `Global Parameters` menu.

![global params](../assets/globalparameters.png)

You can see the newly created global parameter is set.

![global param set](../assets/rexpulltrue.png)

Unregister the host `rhel1`.
=======================================================================================

In the `Satellite Server` terminal run the following command.

```
ssh -o "StrictHostKeyChecking no" rhel1 "subscription-manager unregister" && hammer host delete --name rhel1 && ssh -o "StrictHostKeyChecking no" rhel1 "dnf remove -y katello-pull-transport-migrate"
```

This command is run to remove `rhel1` from the satellite server so that we can register it again to show REX pull mode is automatically enabled.

Register `rhel1` to show automatic configuration of REX pull mode.
==================================================================

You can re-use the registration command created at the beginning of this activity to register `rhel1`. It will be configured with REX pull mode on.

You can regenerate a new registration command with the same hammer command.

```
hammer host-registration generate-command --insecure 1 --setup-insights 0 --force 1 --activation-key RHEL9
```
Here's what the registration operation output looks like for `rhel1`.

![rex pull](../assets/rexpullrhel1auto.png)

Notice the installation of `yggdrasild` components.

You can check to see if REX pull mode was successfully configured on `rhel1` by checking the yggdrasild demon is running.

```
systemctl status yggdrasild
```

Apply installable errata to `rhel1`.
================================================

Navigate to the `Errata` menu.

![errata](../assets/erratamenubar.png)

Filter for the installable errata.

![filter](../assets/installable.png)

Select the installable errata.

![installable](../assets/selectallerrata.png)

Click `Apply errata`.

![apply](../assets/applyerrata.png)

In the `Apply errata` wizard, do the following.

1) Select `rhel1`.
2) Click `Next`.

![apply](../assets/applyerratawizard.png)

Click `Confirm`.

Click confirm to apply the errata.

To view the application of Errata in real-time, click on the host `rhel1`.

![view](../assets/viewapplicationoferratahost.png)

On the following page, you'll be able to see the application process.

![process](../assets/process.png)

To return to the job status page, click `Back to Job`.

![back to job](../assets/backtojob.png)

When the job is complete, the page will look like this.

![complete](../assets/completejobstatus.png)
