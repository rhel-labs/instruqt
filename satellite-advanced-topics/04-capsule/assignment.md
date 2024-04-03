---
slug: capsule
id: otxgdefrlsjo
type: challenge
title: Configure a Capsule Server
teaser: Configure a capsule server.
notes:
- type: text
  contents: Capsule servers enable you to scale your Satellite infrastructure by providing
    software and updates through the capsule servers while enabling you to manage
    them through the main Satellite server.
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Capsule
  type: terminal
  hostname: capsule
- title: Capsule Web UI
  type: external
  url: https://capsule.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
difficulty: ""
---
In this assignment, we'll configure the host `capsule.lab` as a Capsule server.

Red Hat Satellite Capsule Servers mirror content from Red Hat Satellite Server to facilitate content federation across various geographical locations. Host systems can pull content from the Capsule Server and not from the central Satellite Server. The Capsule Server also provides localized services such as Puppet Master, DHCP, DNS, or TFTP. Capsule Servers assist you in scaling your Satellite environment as the number of your managed systems increases.

Capsule Servers decrease the load on the central server, increase redundancy, and reduce bandwidth usage.

Synchronize the repositories containing capsule server software to the Satellite server
========================================================================================

We need to provide the following repositories to the capsule server.

- `rhel-8-for-x86_64-baseos-rpms`
- `rhel-8-for-x86_64-appstream-rpms`
- `satellite-capsule-6.14-for-rhel-8-x86_64-rpms`
- `satellite-maintenance-6.14-for-rhel-8-x86_64-rpms`

Copy and paste the following playbook to the satellite server in the `Satellite Server` terminal.

```
tee ~/capsulerepos.yml << EOF
---
- name: Add and sync capsule server repositories.
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Enable RHEL 8 BaseOS RPMs repository with label"
    redhat.satellite.repository_set:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      label: rhel-8-for-x86_64-baseos-rpms
      repositories:
        - releasever: "8"

  - name: "Enable RHEL 8 AppStream RPMs repository with label"
    redhat.satellite.repository_set:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      label: rhel-8-for-x86_64-appstream-rpms
      repositories:
        - releasever: "8"

  - name: "Satellite 6 client repository with label without specifying base arch"
    redhat.satellite.repository_set:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      label: satellite-client-6-for-rhel-8-x86_64-rpms
      all_repositories: true
      state: enabled

  - name: "Satellite capsule software for 6.14"
    redhat.satellite.repository_set:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      label: satellite-capsule-6.14-for-rhel-8-x86_64-rpms
      all_repositories: true
      state: enabled

  - name: "Satellite maintenance software for 6.14"
    redhat.satellite.repository_set:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      label: satellite-maintenance-6.14-for-rhel-8-x86_64-rpms
      all_repositories: true
      state: enabled

  - name: "Create activation key for capsule."
    redhat.satellite.activation_key:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      name: "RHEL8"
      organization: "Acme Org"
      lifecycle_environment: "Library"
      content_overrides:
          - label: satellite-client-6-for-rhel-8-x86_64-rpms
            override: enabled
          - label: satellite-maintenance-6.14-for-rhel-8-x86_64-rpms
            override: enabled
          - label: satellite-capsule-6.14-for-rhel-8-x86_64-rpms
            override: enabled

  - name: "Sync all RHEL repositories"
    redhat.satellite.repository_sync:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      product: "Red Hat Enterprise Linux for x86_64"
      organization: "Acme Org"

  - name: "Sync Satellite Capsule repository"
    redhat.satellite.repository_sync:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      product: "Red Hat Satellite Capsule"
      organization: "Acme Org"
EOF
```

Notice that the `Modify activation key` task of the playbook overrides the aforementioned repositories to `enabled`, providing `capsule` access to the repos.

Run the playbook.

```
ansible-playbook capsulerepos.yml
```

The RHEL 8 repositories were synchronized in the background of this lab. The synchronization step should only take a few seconds.

Register the Capsule host with Satellite
=========================================

Register the host `capsule` with satellite.

You can generate a host registration script on the `Satellite Server` terminal with the following command.
**Note:** this is a different registration script from those previously generated in this lab and provides access to RHEL 8 repos.

```
hammer host-registration generate-command --insecure 1 --setup-insights 0 --force 1 --activation-key RHEL8
```

Copy the output of this command from the `Satellite Server` terminal, paste it into the `Capsule` terminal, and run it.

Update the capsule.lab host
============================

In the `Capsule` terminal, run the following.

```
dnf update -y && reboot
```

The `Capsule` terminal will lose connection with the host during reboot. To reconnect the `Capsule` terminal, click the following button.

![reconnect](../assets/refreshcapsuleterminal.png)

Configure the repositories on the Capsule host
===============================================

To install the capsule software, we have to configure the correct repositories. Run the following command in the `Capsule` terminal to disable repos.

```
subscription-manager repos --disable "*"
```

Now enable the repositories the required repositories.

```
subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms \
--enable=rhel-8-for-x86_64-appstream-rpms \
--enable=satellite-capsule-6.14-for-rhel-8-x86_64-rpms \
--enable=satellite-maintenance-6.14-for-rhel-8-x86_64-rpms
```

Enable the satellite module.

```
dnf module enable satellite-capsule:el8 -y
```

__Note:__ Enabling the `satellite-capsule:el8` module will throw several warnings. Ignore them since there are no installations of ruby or postgresql on this host.

Install the capsule software
=============================

Run the following command to install the capsule software.

```
dnf install satellite-capsule -y
```

While the capsule software is installing, you can proceed to the next step.

Export the Default SSL Certificate from the Satellite server
============================================================

On the **Satellite server**, in the `Satellite Server` terminal, create a directory to store the SSL certificate.

```
mkdir /root/capsule_cert
```

Generate the capsule certificate by entering the following in the `Satellite Server` terminal.

```
capsule-certs-generate \
--foreman-proxy-fqdn capsule.lab \
--certs-tar /root/capsule_cert/capsule.lab-certs.tar
```

Notice that FQDN for the capsule server, `capsule.lab` must be specified.

Here's what the output should look like.

![capsule certs gen](../assets/capsulecertgen.png)

Note the instructions in the output of the command. You'll need these!

Copy the certificate from `satellite.lab` to `capsule.lab`
==========================================================

Copy the certificate from `satellite.lab` to `capsule.lab`.

```
scp -o StrictHostKeyChecking=no /root/capsule_cert/capsule.lab-certs.tar capsule.lab:/root/capsule.lab-certs.tar
```

![scp cert](../assets/scpcerts.png)

Run the capsule configuration task
======================================

Before proceeding, check that the capsule software installation is complete.

As per the instructions from the output of the `capsule-cert-generate`, copy, paste and run the `satellite-installer` command in the `Capsule` terminal.

![instructions](../assets/certssatelliteinstaller.png)

Here's what the output should look like.

![capsuleoutput](../assets/capsuleoutput.png)

![capsulecopy](../assets/capsuleop.gif)

Discussion
==========

In this part of the lab, we'll talk about capsule deployment strategies while the capsule is configured.

Configure lifecycle environment and content views
=================================================

At present, the capsule server `capsule.lab` cannot provide any software. To do so, we must synchronize metadata to `capsule.lab`, that is, information about the software and repositories available to `satellite.lab`. It is possible to synchronize all metadata and software packages to `capsule.lab` but it can take a lot of time and consume a lot of storage. We control the synchronization of software repositories to capsule servers through lifecycle environments.

The `satellite.lab` server only has a single lifecycle environment (LCE) named `Library`. `Library` is a default LCE and contains all repositories. To synchronize all metadata (we have not specified that all software must be synchronized), we could tell satellite to synchronize the entire `Library` LCE to the capsule.

In a real-life environment, it is not always practical or desireable to synchronize all software to capsule servers since it could take a long time and consume a vast amount of storage.

Content views are used to specify repositories and provide granular control of specific RPM package versions that can be added to a lifecycle environment. We'll use a combination of a content view and an LCE to synchronize RHEL 9 BaseOS, AppStream, and Satellite Client software to the capsule server `capsule.lab`.

To read more about lifecycle environments, please refer to the official documentation [here](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.14/html/managing_content/managing_application_lifecycles_content-management).

To read more about content views, please refer to the official documentation [here](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.14/html/managing_content/managing_content_views_content-management).

Copy and paste the following playbook into the `Satellite Server` terminal.

```
tee ~/capsulesync.yml << EOF
---
- name: Configure a lifecycle environment and a content view.
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Create the Capsule Production lifecycle environment"
    redhat.satellite.lifecycle_environment:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      name: "Capsule Production"
      label: "capsule_production"
      prior: "Library"
      state: "present"

  - name: "Create RHEL9 content view"
    redhat.satellite.content_view:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      name: "RHEL9"
      repositories:
        - name: 'Red Hat Enterprise Linux 9 for x86_64 - BaseOS RPMs 9'
          product: 'Red Hat Enterprise Linux for x86_64'

  - name: "Publish a content view and promote that version to Capsule Production LCE, not idempotent"
    redhat.satellite.content_view_version:
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      username: "admin"
      content_view: "RHEL9"
      lifecycle_environments:
        - "Capsule Production"
EOF
```

Run the playbook.

```
ansible-playbook capsulesync.yml
```

This playbook creates the LCE named "Capsule Production" and the content view "RHEL9" which contains the RHEL9 BaseOS repository.

__Note:__ For the purposes of this lab, all of this content has been seeded to the satellite server so the synchronization should take only a few minutes.

Configure satellite.lab to replicate the Capsule Production lifecycle environment to capsule.lab
================================================================================================
In the `Satellite Web UI`, navigate to the capsule menu.

![capsule menu](../assets/capsulemenu.png)

You should see the capsule server.

Click on `capsule.lab`

![capsule server](../assets/capsulelabinmenu.png)

Click on `Edit`.

![edit capsule](../assets/editcapsulesettings.png)

Click on `Lifecycle Environments`.

![capsule edit](../assets/capsuleconfiglifecycleenv.png)

Click on `capsule.lab`.

![capsule server](../assets/capsulelabinmenu.png)

Configure `satellite.lab` to synchronize the `Capsule Production` lifecycle environment to `capsule.lab`.

1. Click on `Capsule Production`.
2. Click `Submit`.

![config lce](../assets/clicklibrary.png)

Click on `Optimized Sync` to synchronize repo metadata to the capsule.

![opt sync](../assets/optimizedsync.png)

**A note about the configuration:**

![download policy](../assets/downloadpolicy.png)

We left the `Download Policy` on the default setting of `On Demand`. This means that metadata will be synchronized to the capsule server but the software will only be synchronized on demand, when a host makes the request to the capsule server to install software.

Migrate rhel1 to the capsule server.
====================================
In the `rhel1` terminal enter the following command to view the redhat.repo file.

```
cat /etc/yum.repos.d/redhat.repo
```

The output will look like this.

![](../assets/satelliteredhatrepo.png)

`rhel1` is using the BaseOS, AppStream and Satellite Client repositories provided by the `satellite.lab` server.

When we migrate `rhel1` to `capsule.lab`, `rhel1` will only have access to the BaseOS repository as configured in the `RHEL9` content view.

Navigate to the `All Hosts` menu.

![all hosts](../assets/allhosts.png)

Do the following.

1) Select `rhel1`.
2) Click `Change Content Source`.

![change content source](../assets/changecontentsource.png)

Perform the following actions.

1) Select `capsule.lab` in the `Content source` dropdown.
2) In the `Lifecycle environment` section, choose `Capsule Production`.
3) Choose the content view `RHEL9`.
4) Click `Run job invocation`.

![change menu](../assets/changecontentsourcemenu.png)

In the `Run job` menu, click on `Run on selected hosts`.

![run on select](../assets/runonselectedhostschangehosts.png)

You can verify that `rhel1` was successfully migrated to `capsule.lab` by viewing the `/etc/yum.repo.d/redhat.repo file.

In the `rhel1` terminal, run this.

```
cat /etc/yum.repos.d/redhat.repo
```

![verify capsule migration](../assets/verifycapsulemigration.png)

The `redhat.repo` will show that the baseurl points at `capsule.lab`. As well, `rhel1` only has access to the `BaseOS` repository as defined in the `RHEL9` content view.

Please not that you would normally also provide access to the `AppStream` repository as well. `AppStream` was ignored in order to save time.
