---
slug: step3
id: zpyqyyzw9vhk
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
An update to the web application running on this system requires features available in ruby 3.1.  To accomplish this you will ultimately remove ruby 3.0 and install ruby 3.1.

To start, how do you know that ruby 3.1 is availble?  Additional software for Red Hat Enterprise Linux is shipped as an Application Stream.  Application Streams take several different forms, but ruby is packaged and shipped as a module.

List the available ruby modules.

```bash
dnf module list ruby
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
Name        Stream        Profiles          Summary                                                   
ruby        3.1           common [d]        An interpreter of object-oriented scripting language      

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
</pre>

From the above output, you can see that ruby 3.1 is available and can be installed on the system.

In order to upgrade the system, first remove ruby 3.0.

```bash
dnf -y remove ruby
```

Take a look at the machine to validate the removal of ruby 3.0.

```bash
dnf list ruby
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Available Packages
ruby.i686                        3.0.4-160.el9_0                      rhel-9-for-x86_64-appstream-rpms
</pre>

Previously, the dnf list showed ruby in the `Installed Packages`.  Now that it has been removed from the system, it is listed in the `Available Packages`.
