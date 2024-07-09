---
slug: connecting
id: bbyocmqwuayu
type: challenge
title: Connecting a RHEL system with rhc
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
In this step, we're going to connect and register our system to Red Hat using the `rhc` tool. First, let's talk a little bit about what `rhc` does.

`rhc connect` will initiate the basic connection workflow, and prompt you for a username and password.  This username and password are your Red Hat customer portal credentials, the same credentials that you would log in to [The Red Hat Hybrid Cloud Console](https://cloud.redhat.com) or [The Red Hat Customer Portal](https://access.rehdat.com/) with.  You can also specify these credentials with the `--username` and `--password` command line options for `rhc`, or you can use the `--activation-key` command line argument to attach using an activation key.  An activation key is the best way to attach automatically, without entering a password in clear text at the command line or stored in a script.

We have an activation key stored as an environment variable in this system, so we'll connect this system using that key.

> [!NOTE]
> When using an activation key, you also need to specify your organization ID.  You can create activation keys in the [Customer Portal](https://access.redhat.com/management/activation_keys).  The details page of your activation key once created, displays your Organization ID.

```bash,run
rhc connect --activation-key ${KEY} --organization 12451665
```

While connecting, rhc will tell you the hostname of the system you are connecting, copy this down for future use.

<pre>
# rhc connect --activation-key ${KEY} --organization 12451665
Connecting rhel-96b5b to Red Hat.
This might take a few seconds.

● Connected to Red Hat Subscription Management
● Connected to Red Hat Insights
● Activated the Red Hat connector daemon

Manage your Red Hat connector systems: https://red.ht/connector
</pre>

Connecting a system using `rhc` will accomplish a few things for you. First, it connects your system to Red Hat Insights. Insights is a service that you have access to simply because you are running RHEL. It will also enable remote remediation of issues identified by Insights with the proper add-on subscription.  And lastly, if your organization has Simple Content Access enabled, your system will be setup to receive updates from Red Hat.

> [!NOTE]
> If your organization does not have Simple Content Access enabled, you will need to attach a subscription after connecting with `rhc` using the `subscription manager` tool.

> [!NOTE]
> If you are connecting a cloud system in a pay-as-you-go model, no subscription is required, and rhc will not consume one.

In the next step, we'll have a look at what we can do with Insights and the Hybrid Cloud Console.
