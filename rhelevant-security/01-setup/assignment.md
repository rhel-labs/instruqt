---
slug: setup
id: rg9bxebwrggz
type: challenge
title: Lab Setup
notes:
- type: text
  contents: |
    # Goal:

    Learn about, and deploy practical security goals on Red Hat Enterprise Linux

    <blockquote>
    <p>
    <strong>NOTE:</strong> This lab environment will expire in less than two hours.
    </p>
    </blockquote>
tabs:
- id: krseticr3gzj
  title: bastion
  type: terminal
  hostname: bastion
- id: v4y7wtnzosyu
  title: node1
  type: terminal
  hostname: node1
difficulty: basic
timelimit: 6900
enhanced_loading: null
---
# RHPDS Lab Setup


Lab Length
Medium/Average (~10-20 mins)

Goal
Become familiar with the Summit lab environment

## 1.1: Introduction

In this scenario you are a system administrator given a task to harden a Red Hat Enterprise Linux system. You have no idea what is on the system, what it is running, the hardware, or software installed. You are working on a black box.

You are given credentials that should give you access to the machine. You are given a Jump Box also known as a bastion host or as a control node, and a username to log in with.

Instead of having to type in the username and password, we are going to set up ssh keys for authentication.
In this lab, ssh keys have been made and put on the end machine.

So first thing we need to do is to check the SSH key from our bastion host to connect to the machines we will be working on.

There are 2 machines we will be connecting to.

* bastion
* node1

## 1.2: Create a SSH key pair

From your bastion host, open a terminal

You should see a prompt with your current username and the hostname of the machine you are logged into.

`
[lab-user@bastion ~]$
`

**Explanation of what you see in the terminal**


* `lab-user` is the current logged in user
* `@` is the at symbol which shows that you are connecting to a remote machine
* `bastion` is the current machine hostname



We want to find out if the current machine has any ssh keys under the users `.ssh` directory.


```bash
ls ~/.ssh/
```

**Explanation of this command:**

`ls` lists the files in the working directory.

`~` aka tilda key, is a shortcut to reffer to your users home directory.

`~/.ssh/` means it's going to `/home/username/.ssh/`

Next we see there are files in the directory.

You should now see 2 randomly named files called ‘xxxxxxx.pem’ and ‘xxxxxxx.pub’


<pre>
[lab-user@bastion ~]$ ls ~/.ssh/
authorized_keys  config  xxxxxxx.pem  xxxxxxx.pub
</pre>


## 1.3 Logging onto node1

Up to this point we have been using the lab-user account on our bastion host.
On other machine 'node1' we have a different user we need to log in with.,

We want to test our credentials by logging into the node machine by typing the following into the terminal.

```bash
ssh ec2-user@node1
```

**Explanation of this command:**

`ssh` Secure Shell, is a cryptographic network protocol that enables secure remote connections and data sharing between two computers over an unsecured network

`ec2-user` the account username of the machine we want to log into

`@` the address we want to connect to

`node1` is the name of the device we want to log into. This could also be an Ip address or a FQDN


If you where successful in your connection, you should see a prompt with your current username and the hostname of the machine you are logged into.


<pre>
[ec2-user@node1 ~]$
</pre>

For one of our upcoming steps, we need to find out what our ip address for node 1 is.
Your IP WILL BE DIFFERENT from what you see in the documentaion, and it will be be different from the other people in the workshop.

In your terminal type

```bash
ip addr
```

**Explanation of this command:**

`ip addr` lists each of your networking devices and the infomation about them.

You want to find the ip address for the ethernet interface.

You should have a few different devices.

<pre>
<---------Output_Abbreviated------------------->
1: lo: <LOOPBACK,UP,LOWER_UP
   link/loopback
   inet 127.0.0.1
2: enp9s0u2u1u2 <NO-CARRIER,BROADCAST,MULTICAST,UP>
   link/ether
   inet 192.168.0.112
<---------Output_Abbreviated------------------->
</pre>

It will be the interface with the "link/ether",
and make note of that IP Address for a future step.

You can now exit the node machine by typing,

```bash
exit
```

Which should take you back to your bastion host.

## 1.4 Install Web Console

We are going to install Cockpit AKA Web Console, on our bastion machine, which gives us a website to admin our linux system.

Open a terminal on your host machine, and type

```bash
sudo yum install cockpit -y
```

Later in the instructions we will start the service with the command below.
We are leaving it off for now to opimize your machine resources.

```bash
sudo systemctl enable --now cockpit.socket
```

Now we are ready to step into the next section.