---
slug: updateerratum
id: bv7ctkkjenqv
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

![errata menu bar](../assets/erratamenubar.png)

You'll be taken to a page containing all the Errata contained in the repositories we originally synchronized in the second challenge of this lab.

Not all of these Errata apply to the hosts we've added to this Satellite server. To view applicable and installable Errata, click on the `Applicable` and `Installable` radio boxes.

![applicable and installable](../assets/applicableandinstallable.png)

Let's install all the applicable Errata to our two hosts.

Select all of the Errata we just filtered.

![select all](../assets/selectallerrata.png)

You'll be taken to the Apply Errata menu where you should do the following:

1) Select the hosts to apply the Errata. In this case we'll select all hosts.
2) Click `Next`.

![apply errata wizard](../assets/applyerratawizard.png)

To view the application of Errata in real-time, click on the host `rhel1`.

![view](../assets/viewapplicationoferratahost.png)

On the following page, you'll be able to see the application process.

![process](../assets/process.png)

To return to the job status page, click `Back to Job`.

![back to job](../assets/backtojob.png)

When the job is complete, the page will look like this.

![complete job status](../assets/completejobstatus.png)

Go to Hosts > All Hosts.

![all hosts](../assets/allhosts.png)

All hosts managed by Satellite should display in a green font signifying all hosts are up to date and there are no errors logged.

![green](../assets/green.png)
