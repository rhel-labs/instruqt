---
slug: rhc-intro
id: ugf1knxcecri
type: challenge
title: Introduction to the remote host configuration tool
notes:
- type: text
  contents: |
    After completing this scenario, users will have familiarity with the remote host configuration
    tool, rhc. rhc is a tool provided with Red Hat Enterprise Linux designed to make system
    registration and connection to Red Hat's hosted services easier.

    # Concepts included in this scenario:
    * Connecting a system to the Red Hat Hybrid Cloud Console using rhc.
    * Demonstration of what connecting to Red Hat with rhc gains you.

    # Example use case:
    You have new RHEL systems that you would like connected to the hybrid cloud console and connected
    to your Red Hat subscriptions.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
---
`rhc` is a tool used to register systems to Red Hat and connect them to the Hybrid Cloud Console at the same time.  This is useful because the Hybrid Cloud Console is where you'll find Red Hat Insights.  Insights is a powerful tool that you get simply by virtue of having a RHEL subscription, even if you're using RHEL through your cloud provider's pay-as-you-go program.

`rhc` is already installed for you on this system, but in some cases you may need to install it before you can proceed.  In a pay as you go cloud model you'll simply be able to `dnf install rhc` and it will be pulled from your cloud providers repositories.  A minimal RHEL install however may not have `rhc` installed.  In which case you will either have to add it at intall time, install it using your RHEL install media, or subscirbe your system using `subscription manager` to install it.

Let's have a look at the options `rhc` includes.

```bash
rhc --help
```

<pre>
# rhc --help
NAME:
   rhc - control the system's connection to Red Hat

USAGE:
   rhc [global options] command [command options] [arguments...]

VERSION:
   0.2.1

DESCRIPTION:
   The rhc command controls the system's connection to Red Hat.

   To connect the system using an activation key:
     rhc connect --organization ID --activation-key KEY

   To connect the system using a username and password:
     rhc connect --username USERNAME --password PASSWORD

   To disconnect the system:
     rhc disconnect

   Run 'rhc command --help' for more details.

COMMANDS:
   connect     Connects the system to Red Hat
   disconnect  Disconnects the system from Red Hat
   status      Prints status of the system's connection to Red Hat
   help, h     Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h     show help (default: false)
   --version, -v  print the version (default: false)
</pre>

As you can see, there are several options at our disposal, including several ways to automate the registration process.

In the next step, we'll register a system to Red Hat using `rhc`
