---
slug: configure-host-group
id: g5y0soyte7j1
type: challenge
title: Configure a Host Group
teaser: Host groups are used to organize and configure sets of hosts.
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
timelimit: 0
---

Red Hat Satellite provides several logical units for grouping hosts. Hosts that are members of those groups inherit the group configuration. It is recommended to configure the majority of settings at the host group level instead of defining hosts directly. Configuring a new host then largely becomes a matter of adding it to the right host group. As host groups can be nested, you can create a structure that best fits your requirements.

For more information on Host Groups, please see the [documentation](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.12/html/satellite_overview_concepts_and_deployment_considerations/chap-architecture_guide-host_grouping_concepts).

Navigate to the `Host Groups` menu.

![host groups menu](../assets/menuhostgroups.png)

Click on `Create Host Group`.

![create host group](../assets/createhostgroupbutton.png)


