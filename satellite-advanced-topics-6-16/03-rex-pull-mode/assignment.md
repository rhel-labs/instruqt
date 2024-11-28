---
slug: rex-pull-mode
id: tixjilsnkhvy
type: challenge
title: Configure Remote Execution (REX) Pull Mode
teaser: Learn how to configure remote execution pull mode and how to migrate hosts
  to it.
notes:
- type: text
  contents: Configure Remote Execution pull mode.
tabs:
- id: hhr09rhbykkg
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: tz9a2kadx2mo
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: 63hbpebuwdcm
  title: rhel1
  type: terminal
  hostname: rhel1
difficulty: ""
timelimit: 0
enhanced_loading: null
---

Since Satellite 6.12, Remote Execution or REX has provided the option of a "pull mode". Remote execution pull mode uses Message Queuing Telemetry Transport (MQTT) to publish jobs on Capsule servers (or Capsule service running on a Satellite server). Managed hosts subscribe to the MQTT broker to receive REX job notifications.

REX pull mode is useful for organizations that wish to reduce the amount of incoming traffic permitted for Red Hat Enterprise Linux hosts. Rather than allowing remote execution operations through SSH, REX pull mode listens for messages from the Satellite server to download and run remote execution operations.

Here’s how REX Pull mode works:

1. A managed host receives MQTT notification that there is a new REX job.
2. The managed host downloads the job “payload” via HTTPS from the Capsule service (in this lab the capsule service is running on the Satellite server itself).
3. The job “payload” is run on the host. As the job executes, the progress of the job is reported back to the Capsule service.

Here are the configuration considerations:

1. Port 1883 (MQTT) must be opened on the Satellite server running the Capsule service to allow incoming requests to subscribe to REX pull notifications, and the host must be allowed to connect to the Capsule server on port 443 (HTTPS) to enable REX pull mode.
2. Capsule servers (and Capsule services) must be configured to support either REX SSH mode or REX pull mode. You cannot configure a Capsule to support both REX modes.
3. For existing hosts running the katello agent, you can migrate to REX pull mode by installing the katello-pull-transport-migrate package. Documentation is provided at the bottom of this post. The katello agent has been deprecated as of Satellite 6.7.

Katello Agent is removed from Satellite 6.15.

Register the host rhel1 to the Satellite server
===================================================

We'll register the host `rhel1` to our Satellite server using the command line interface to generate a registration command in this lab. The host `rhel1` will be configured to use REX in SSH mode, giving us the opportunity to migrate it to pull mode.

It is also possible to generate a registration command from the Satellite WebUI but due to the limitations of DNS in this lab environment, we'll use the cli utility `hammer` to simplify the process.

Click on the [button label="Satellite Server"](tab-0) tab.

![satellite server tab](../assets/satellite-server-tab.png)

Run the following command.

```bash,run
hammer host-registration generate-command --insecure 1 --setup-insights 0 --force 1 --activation-key RHEL9
```

This hammer command create a registration script that uses the RHEL9 activation key. It also ignores self signed certificate erros (`--insecure 1`), ignores insights setup (`--setup-insights 0`), and forces registration with the satellite server (`--force 1`).

The output of this command is a script similar to this (don't copy paste this):

```nocopy
set -o pipefail && curl -sS --insecure 'https://satellite.lab/register?force=true&hostgroup_id=1&setup_insights=false' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJpYXQiOjE2ODI2MjkyNzcsImp0aSI6ImQ1YjFkYThmYzM4OGY5ZjY0MmEyZjc0ZGFhNjRkMmZjODVmZDhiNjU1Y2E3NmM3ODEyYWQ5ZjQzNWE0NWE5Y2UiLCJleHAiOjE2ODI2NDM2NzcsInNjb3BlIjoicmVnaXN0cmF0aW9uI2dsb2JhbCByZWdpc3RyYXRpb24jaG9zdCJ9.bgS1XqSYd4bsY46Suq7QqC5OSKm3bSsN57c3lddiOkU' | bash
```
Copy the output by highlighting the selected text. Once the primary click mouse, button is released, the text will be automatically saved to the clipboard.

![copy paste](../assets/copypaste.gif)

Click this button [button label="rhel1"](tab-2) to switch to the `rhel1` terminal.

> [!IMPORTANT]
> Paste the command into the rhel1 terminal.

> [!WARNING]
> If you paste and run this command in the `Satellite Server` you will register the satellite server to itself and you will have to re-start the lab.

Finally type enter to execute the registration command.

![copy paste rhel1](../assets/registrationrhel1.gif)

Enable pull mode on the Satellite server
===================================================

Click this button [button label="Satellite Server"](tab-0) to switch to the `Satellite Server` terminal and click `run` to run the following command. This command installs the MQTT broker on the `Satellite Server`.

```bash,run
satellite-installer --foreman-proxy-plugin-remote-execution-script-mode pull-mqtt
```

Open required firewall ports on the Satellite server
===================================================

Open the required firewall ports with the following command in the [button label="Satellite Server"](tab-0) tab.

```bash,run
firewall-cmd --permanent --add-port="1883/tcp" && firewall-cmd --reload
```

>[!NOTE]
>There is currently no support for changing this port to a different port number.

Port 1883 is required to be open on the Satellite server to enable hosts to subscribe to updates. That is, the RHEL hosts need to be able to tell the Satellite server that they are listening for messages that REX jobs are available to be run.

Upon notification that a REX job is available, the RHEL host downloads the REX job from the Satellite server via HTTPS (port 443).

Configure jobs to be sent through the capsule service that the host was registered to
===================================================

The following setting enables hosts to receive REX jobs through the satellite or capsule server they were registered through. If this setting is not made, REX jobs would be dispatched through a satellite or capsule server depending on the following [rules in this document](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.15/html/managing_hosts/configuring_and_setting_up_remote_jobs_managing-hosts#remote-execution-workflow_managing-hosts).

Copy and run this in the [button label="Satellite Server"](tab-0) terminal.

```bash,run
tee ~/rexsetting.yml << EOF
---
- name: Configure Satellite 6.15
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

```bash,run
ansible-playbook rexsetting.yml
```

Migrate the rhel1 host to REX pull mode
===================================================

At the beginning of this assignment, we registered the host `rhel1` to use REX in "push" or SSH mode. We'll now migrate it to "pull" mode.

Click this button [button label="rhel1"](tab-2) to switch to the `rhel1` tab and install `katello-pull-transport-migrate` by running the following command.

```bash,run
dnf install katello-pull-transport-migrate -y
```
>[!NOTE]
>The `katello-pull-transport-migrate` package is provided by the `satellite-client-6-for-rhel-9-x86_64-rpms` repository. This repo was added to the satellite server and enabled by the activation key in the second task of this lab.

Check that the MQTT agent `yggdrasild` is running.

```bash,run
systemctl status yggdrasild
```

The output should look like the screenshot below.

![yggdrasild service](../assets/yggdrasildservicestatus.png)

Test out REX pull mode
===================================================

Now we'll run a test to confirm that REX pull mode is working. On [button label="rhel1"](tab-2), run the following command to tail the `messages` log file.

```bash,run
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

1. Enter `uname -a` in the `command` box.

2. Click `Run on selected hosts`.

![target](../assets/targethostsandinputs.png)

The REX pull mode job will execute. Once the `Results` menu shows 100%, click on the `rhel1` tab.

The `messages` log file should display something similar to this.

![ygg successful](../assets/successfulyggdrasild.png)

Configure Satellite to automatically configure REX pull mode when registering new hosts
===================================================

At present, Satellite will register hosts in REX SSH mode by default. We'll need to set a new Global Parameter to enable pull mode by default, with a global parameter. In the [button label="Satellite Server"](tab-0) terminal, enter the following command.

```bash,run
tee ~/rexdefault.yml << EOF
---
- name: Configure Satellite 6.15
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

Run the playbook in the [button label="Satellite Server"](tab-0) terminal.

```bash,run
ansible-playbook rexdefault.yml
```

This playbook creates a global parameter `host_registration_remote_execution_pull` with the value of `true`.

You can check to see this parameter was successfully created by navigating to the `Global Parameters` menu.

![global params](../assets/globalparameters.png)

You can see the newly created global parameter is set.

![global param set](../assets/rexpulltrue.png)

Unregister the host rhel1
===

In the [button label="Satellite Server"](tab-0) terminal run the following command.

```bash,run
ssh -o "StrictHostKeyChecking no" rhel1 "subscription-manager unregister" && hammer host delete --name rhel1 && ssh -o "StrictHostKeyChecking no" rhel1 "dnf remove -y katello-pull-transport-migrate"
```

This command is run to remove `rhel1` from the satellite server so that we can register it again to show REX pull mode is automatically enabled.

Register rhel1 to verify automatic configuration of REX pull mode
===

You can re-use the registration command created at the beginning of this activity to register `rhel1`. It will be configured with REX pull mode on.

Or if you wish, in the [button label="Satellite Server"](tab-0) terminal, you can regenerate a new registration command with the original hammer command.

```bash,run
hammer host-registration generate-command --insecure 1 --setup-insights 0 --force 1 --activation-key RHEL9
```
Switch to the [button label="rhel1"](tab-2) tab and paste the registration script.

>[!NOTE]
>If you are still tailing the yggdrasild log on the rhel1 host, type ctrl-c to quit.

Here's what the registration operation output looks like for `rhel1`.

![rex pull](../assets/rexpullrhel1auto.png)

Notice the installation of `yggdrasild` components.

You can check to see if REX pull mode was successfully configured on[button label="rhel1"](tab-2) by checking the yggdrasild demon is running.

```bash,run
systemctl status yggdrasild
```

Force a single errata to be detected on rhel1
===

In this step, we'll downgrade `vim` in to compel Satellite to detect that at least one errata is installable on `rhel1`. This prepares `rhel1` for the next step where we will install errata with REX pull mode.

Run the following command in the [button label="rhel1"](tab-2) tab.

```bash,run
dnf downgrade -y vim
```


Apply installable errata to rhel1 using REX pull mode
===

Navigate to the `Errata` menu.

![errata](../assets/erratamenubar.png)

Filter for the installable errata.

![filter](../assets/installable.png)

Select the installable errata.

![installable](../assets/selectallerrata.png)

Click `Apply errata`.

![apply](../assets/applyerrata.png)

In the `Apply errata` wizard, do the following.

1. Select `rhel1`.
2. Click `Next`.

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

>[!NOTE]
>Don't wait for the updates to complete. Please advance to the next assignment.

![complete](../assets/completejobstatus.png)
