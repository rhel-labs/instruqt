---
slug: step4
id: ha8amxone7ch
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Now you can install ruby version 3.1 on the system.  However, it is also important to note that Application Streams often have a different lifecycle than other packages provided with Red Hat Enterprise Linux.  According to the RHEL 9 Aplications Streams Release Lifecycle section of the [Application Streams Lifecycle Page](https://access.redhat.com/support/policy/updates/rhel-app-streams-life-cycle), ruby 3.1 will be retired in March 2025. 

However, for our application, that is fine because we expect continued development and will likely be upgrading to an even newer version of ruby at some point during our application life.  Go ahead and install ruby 3.1 on the system:

```bash
dnf -y module install ruby:3.1
```

You can verify that ruby 3.1 is now available on the system by checking the version reported by ruby:

```bash
ruby --version
```

<pre class="file">
<< OUTPUT ABRIDGED >>
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]
</pre>
