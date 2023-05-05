---
slug: updateerratum
id: l2qmabvqkuxe
type: challenge
title: Apply Errata to hosts
teaser: Apply Errata to hosts
notes:
- type: text
  contents: Apply Errata to hosts
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
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

Red Hat Product Errata are contain advisories on bug fixes, security, and enhancement on software installed on your RHEL host, based on analysis by Red Hat engineers. Red Hat Satellite provides a simple method for applying these fixes to hosts. We'll walk through those steps.

For more information on Red Hat Errata, [please visit this page](https://access.redhat.com/articles/2130961).

To view Errata in Satellite, click on `Content` and `Errata`.

<a href="#1">
 <img alt="An example image" src="../assets/erratamenubar.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/erratamenubar.png" />
</a>

You'll be taken to a page containing all the Errata contained in the repositories we originally synchronized in the second challenge of this lab.

Not all of these Errata apply to the hosts we've added to this Satellite server. To view applicable and installable Errata, click on the `Applicable` and `Installable` radio boxes.

<a href="#2">
 <img alt="An example image" src="../assets/applicableandinstallable.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/applicableandinstallable.png" />
</a>

Let's install all the applicable Errata to our two hosts.

Select all of the Errata we just filtered.

<a href="#3">
 <img alt="An example image" src="../assets/selectallerrata.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/selectallerrata.png" />
</a>

_**Note:**_ Increase the pager size to select all the errata.

![pager](../assets/pagersize.png)

You'll be taken to the Apply Errata menu where you should do the following:

1) Select the hosts to apply the Errata. In this case we'll select all hosts.
2) Click `Next`.

<a href="#4">
 <img alt="An example image" src="../assets/applyerratawizard.png" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/applyerratawizard.png" />
</a>

Click confirm to apply the errata.

To view the application of Errata in real-time, click on the host `rhel1`.

<a href="#5">
 <img alt="An example image" src="../assets/viewapplicationoferratahost.png" />
</a>

<a href="#" class="lightbox" id="5">
 <img alt="An example image" src="../assets/viewapplicationoferratahost.png" />
</a>

On the following page, you'll be able to see the application process.

<a href="#6">
 <img alt="An example image" src="../assets/process.png" />
</a>

<a href="#" class="lightbox" id="6">
 <img alt="An example image" src="../assets/process.png" />
</a>

To return to the job status page, click `Back to Job`.

<a href="#7">
 <img alt="An example image" src="../assets/backtojob.png" />
</a>

<a href="#" class="lightbox" id="7">
 <img alt="An example image" src="../assets/backtojob.png" />
</a>

When the job is complete, the page will look like this.

<a href="#8">
 <img alt="An example image" src="../assets/completejobstatus.png" />
</a>

<a href="#" class="lightbox" id="8">
 <img alt="An example image" src="../assets/completejobstatus.png" />
</a>

Go to Hosts > All Hosts.

<a href="#9">
 <img alt="An example image" src="../assets/allhosts.png" />
</a>

<a href="#" class="lightbox" id="9">
 <img alt="An example image" src="../assets/allhosts.png" />
</a>

All hosts managed by Satellite will still display in a red font signifying there are error statuses. This is because the Tracer application has detected services that require restarting. If the kernel or systemd has been updated, the hosts will require a reboot.

Click on a host (it doesn't matter which, you'll have to perform this procedure twice.)

![error host](../assets/errorhost.png)

Do the following to resolve the traces.

1) Click on the `Traces` tab.
2) Select all the services listed.
3) Click `Restart app`.

![restart](../assets/tracesrestart.png)

_**NOTE:**_ Resolving traces might take a few minutes, especially for a reboot, since the host will wait 60 seconds before initiating the reboot.

Repeat the procedure to resolve Traces with the remaining host.

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
