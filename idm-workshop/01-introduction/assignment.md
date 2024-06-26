---
slug: introduction
id: xdwt3vpkpgdu
type: challenge
title: Install the Identity Management Server
teaser: Introduction and Install the Server.
notes:
- type: text
  contents: |
    ## Introduction

    Identity Management (IdM) in Red Hat Enterprise Linux provides a centralized and unified way to manage identity stores, authentication, authorization and related policies in a Linux-based domain. IdM keeps information in an LDAP store based on 389ds directory server. It provides an integrated Certificate Authority using dogtag certificate system to generate user, device and service certificates. IdM combines these capabilites with MIT kerberos to provide a unified identity and policy environment. IdM leverages the System Security Services Daemon (SSSD) within supported operating systems to coordinate client requests with the IdM server. By consolidating these services and centralizing management, IdM significantly reduces the administrative overhead by eliminating the need to configure services individually and use different tools on different machines.

    IdM is based on the upstream project FreeIPA which is integrated with the Fedora linux distribution and CentOS Stream. It is integrated into Red Hat Enterprise Linux in the same way other upstream components are and undergoes integration testing with other Red Hat products like Red Hat Ansible Automation Platform, Red Hat Satellite, Red Hat Single Sign On, Red Hat OpenShift and more. It is supported on all architectures that Red Hat delivers Red Hat Enterprise Linux on - x86_64, aarch64, PowerLE, System Z/Linux One.

    ![Identity Management Server and Client](../assets/ServerAndClient.png)

    Identity Management is fully supported for servers and clients and is included at no additional cost as part of all Red Hat subscriptions that contain Red Hat Enterprise Linux.

    IdM is one of the few centralized identity, policy, and authorization software solutions that support:

    - Advanced features of Linux operating system environments
    - Unifying large groups of Linux machines
    - Native integration with Active Directory

    IdM creates a Linux-based and Linux-controlled domain:

    - IdM builds on existing, native Linux tools and protocols. It has its own processes and configuration, but its underlying technologies are well-established on Linux systems and trusted by Linux administrators.
    - IdM servers and clients are Red Hat Enterprise Linux machines. IdM clients can also be built on other Linux and UNIX distributions if they support standard protocols.
    - A Windows client cannot be a member of the IdM domain but users logged into Windows systems managed by Active Directory (AD) can connect to Linux clients or access services managed by IdM using their AD credentials. This is accomplished by establishing a native AD cross forest trust between AD and IdM domains.
    - IdM also supports standard integration with Cloud Providers and other identity providers that use OAuth 2.0 and OIDC to grant kerberos tickets to these identities within the IdM domain. This allows integration between a Red Hat Enterprise Linux domain and **Microsoft Azure AD**, as an example.

    In this workshop you will learn how to deploy IdM servers, enrol client machines, define and manage user and service identities. You will set up access policies, configure authorization policy, configure network services to take advantage of IdM's authentication and authorisation facilities, and issue and manage X.509 certificates for services.

    For more information on Identity Management and its purpose in Red Hat Enterprise Linux, please see the [Planning Identity Management](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/planning_identity_management/index) guide on access.redhat.com. Content for this workshop lab has been sourced from Red Hat Identity Management Documention and other sources.
tabs:
- title: IdM Server
  type: terminal
  hostname: idmserver
- title: IdM Web UI
  type: external
  url: https://idmserver.${_SANDBOX_ID}.instruqt.io/ipa/ui/
difficulty: basic
timelimit: 5760
---
<!-- markdownlint-disable MD033 -->
## Welcome to the Identity Management Workshop

### IMPORTANT: Using this lab

> This text is in a resizable frame. Some of the commands you will need are wider than the default area. Use your mouse to grab the resize bar that separates the text from the terminal window and resize the these contents for comfortable viewing.
>
> Some of the commands that you need to execute in the terminal window are provided to you for convenience. They are listed in a code formatted area. Hover over the right side of the area with your mouse to reveal the copy button. Click to copy all the text to the clipboard. See the example below.

```bash
echo "I copied this text using the copy button here >>>"
```

> Expected output is from commands in the terminal window are displayed as code. These sections do not provide a copy button.
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
# echo "This is an example of expected command output."
# This is an example of expected command output.
# echo "The lab UI doesn't provide a copy button for this."
# The lab UI doesn't provide a copy button for this.
# echo "You may want to make the screen wider to see all this."
# You may want to make the screen wider to see all this.
</pre>

With that, let's look at our environment.

### Environment

The lab environment will consist of the following systems:

- 1 Red Hat Identity Management (IdM) server
- 1 IdM client

You are logged into the consoles with root access by the environment. A local user account has also been created that you can use:

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
username: rhel
password: redhat
</pre>

This user is a member of wheel and has sudo access.

You can preform all of the activities in the labs using the root account. The above account has been provided should it become necessary.

<hr>

### Exercise 1.1 - Install the IdM server

The IdM server binaries are provided in the ipa-server package. It is delivered as a modular component in Red Hat Enterprise Linux 8 and 9. The ipa-server package has been installed on the idmserver system within your environment during creation.

The configuration of the IdM server managed by an installer program. We add the **--no-host-dns** parameter to support our lab environment. In a production environment, to ensure proper DNS delegation, DNS forwarding, etc.. checking the host dns entry ensures that our configuration will function as expected. The **--mkhomedir** option is used to ensure that PAM creates missing home directories for users when they login for the first time. IdM also supports automount for those use cases where automount use is authorized.

During the installation of the IdM server you will be asked a number of questions. Please accept the defaults **unless outlined below**.

Using the **IdM Server** tab, start by running the installation command:

```bash
sudo ipa-server-install --no-host-dns --mkhomedir
```

To support our kerberos realm, we want the IdM server to manage our DNS for us. You are asked whether to configure integrated DNS.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
Do you want to configure integrated DNS (BIND)? [no]: <b>yes</b>
</pre>

Answer **yes**

This ensures that the installer configures the underlying standard RHEL BIND implementation.

Kerberos is tightly tied to DNS as clients use DNS for kerberos service discovery. In a DNS zone, there is only one kerberos authority allowed. The service entries for kerberos accept multiple values, however, all systems must belong to the same realm. If there is an Active Directory service running in the same DNS domain we will have a conflict. User and system authentication will randomly fail as there are multiple authorities discovered through DNS. IdM servers and AD servers must belong to separate DNS domains. Typically, AD DNS services delegate to IdM servers for the IdM domain. DNS for the IdM realm can be managed external to the IdM servers, however, the same restriction applies and Active Directory DNS or the DNS supporting AD must delgate appriopriately.

The next series of prompts ask you to verify the installer discovered values for the server hostname, domain name and realm. Accept the default by pressing enter after each of the following questions.

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
Server host name [idmserver.[[ Instruqt-Var key="domain" hostname="idmserver" ]]]:

Warning: skipping DNS resolution of host idmserver.[[ Instruqt-Var key="domain" hostname="idmserver" ]]
The domain name has been determined based on the host name.

Please confirm the domain name [[[ Instruqt-Var key="domain" hostname="idmserver" ]]]:

The kerberos protocol requires a Realm name to be defined.
This is typically the domain name converted to uppercase.

Please provide a realm name [[[ Instruqt-Var key="realm" hostname="idmserver" ]]]:
</pre>

You will need to provide a password for the **LDAP Directory Manager** and
for the **IdM admin** account. It requires a minimum of 8 characters. For both, please use:

```bash
redhat2023
```
There are several more questions related to the DNS configuration, NETBIOS name, and time servers.
- we will not be using forwarders
- we will accept the default NETBIOS name
- we will not specify time servers

You will then be prompted to confirm that you wish to proceed with the installation using the stated configuration.

Answer **yes**

<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
Continue to configure the system with these values? [no]: <b>yes</b>
</pre>

The installation should take about 5-10 minutes. Follow the
remainder of the installation process and examine the output.

The installation will:
* Configure a stand-alone CA (dogtag) for certificate management
* Configure the NTP client (chronyd)
* Create and configure an instance of Directory Server
* Create and configure a Kerberos Key Distribution Center (KDC)
* Configure Apache (httpd)
* Configure SID generation
* Configure the KDC to enable PKINIT
* Install and configure the IdM client software

Once setup is complete, you will presented with a **Next Steps** section.

Please examine these and take note of the firewall ports that are required to be open to the IdM Server system.

<hr>

### Exercise 1.2 - Examine the firewall settings
From a host-based firewall prespective (always recommended),
the network ports have been setup for you as part of the lab
preparation using firewalld. You can examine the configuration
with firewall-cmd. Red Hat provides preconfigured service
settings for easily enabling the appropriate ports for IdM.
Running list-services, you should see a list similar to the following:

```bash
firewall-cmd --list-services
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
cockpit dhcpv6-client dns freeipa-4 freeipa-ldap freeipa-ldaps freeipa-replication freeipa-trust ssh
</pre>

To investigate what is controlled by each service listing, run a command similar to the
following:

```bash
firewall-cmd --info-service freeipa-ldaps
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
freeipa-ldaps
  ports: 80/tcp 443/tcp 88/tcp 88/udp 464/tcp 464/udp 123/udp 636/tcp
</pre>

```bash
firewall-cmd --info-service freeipa-4
```
<pre class="file" style="white-space: pre-wrap; font-family:monospace;">
freeipa-4
  ports:
  protocols:
  source-ports:
  modules:
  destination:
  includes: http https kerberos kpasswd ldap ldaps
  helpers:
</pre>

For information on why these ports are required and how they are used, please see the Identity Management documentation.

<hr>

### Exercise 1.3 - Verify the installation.

Verify that you can authenticate with the new IdM realm using the default admin user and the password you provided.

```bash
kinit admin@[[ Instruqt-Var key="realm" hostname="idmserver" ]]
```

> NOTE: you can omit the realm name as it will be setup as a default in /etc/krb5.conf
> If you wish, you can investigate these settings by reviewing the file. Do not make changes.

Run klist to verify your authenitication token.
```bash
klist
```

Verify all the components of the server are up and running.

```bash
ipactl status
```

Verify the health of the server.
```
ipa-healthcheck
```
A fully-functioning IdM installation returns an empty result of [].

We are now ready to register client systems!