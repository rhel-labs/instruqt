---
slug: addanotherhost
id: 1zyvs3cktv8b
type: challenge
title: Add another host to be monitored
teaser: We'll add another host to be monitored collected and monitored by the Grafana
  host.
notes:
- type: text
  contents: Configure a playbook to install PCP on a new host and add it to be collected
    and monitored by the Grafana host.
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel3
  type: terminal
  hostname: rhel3
- title: RHEL Grafana Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
- title: rhel4
  type: terminal
  hostname: rhel4
difficulty: basic
timelimit: 60
---

```bash
all:
  children:
    servers:
      hosts:
        rhel4:
      vars:
        firewall:
          - service: pmcd
            state: enabled
        metrics_retention_days: 7
    metrics_monitor:
      hosts:
        rhel:
      vars:
        metrics_monitored_hosts:  "{{ groups['servers'] }}"
```

So far we have configured 2 RHEL hosts (`rhel2`, `rhel3`) to be monitored and have their performance metrics collected by host running Grafana and Redis (`rhel`). We'll now edit the play book to configure and add another host `rhel4`. This exercise is useful as you add more and more hosts to your datacenter.

The following configuration file will install PCP on the host `rhel4`. As well, it will tell the `rhel` Grafana host to monitor `rhel4`, in addition to the other hosts. Copy and paste this to the cli and press enter.

```bash
tee -a ~/metrics/addrhel4.yml << EOF
all:
  children:
    servers:
      hosts:
        rhel4:
      vars:
        firewall:
          - service: pmcd
            state: enabled
        metrics_retention_days: 7
    metrics_monitor:
      hosts:
        rhel:
      vars:
        metrics_monitored_hosts:  "{{ groups['servers'] }}"
EOF
```

The following configuration file will configure the playbook to run on `rhel4` and `rhel` but skip configuring the firewall on `rhel` since we've already done it. Copy and paste this to the cli and press enter.

```bash
tee -a ~/metrics/metrics.yml << EOF
- name: Use metrics system role to configure PCP metrics recording
  hosts: servers
  roles:
    - redhat.rhel_system_roles.metrics
    - redhat.rhel_system_roles.firewall

- name: Use metrics system role to configure Grafana
  hosts: metrics_monitor
  roles:
    - redhat.rhel_system_roles.metrics
EOF
```

Now go back to the Grafana dashboard. You should be able to see `rhel4` has been added and metrics are being collected.

![rhel4](../assets/rhel4.png)

Congratulations on completing this lab!

For more information on RHEL System Roles, please consider browsing the following:

- [Automate performance metrics collection and visualization with RHEL System Roles](https://www.redhat.com/en/blog/automate-performance-metrics-collection-and-visualization-rhel-system-roles)
- [Red Hat Enterprise Linux System Roles blog series](https://www.redhat.com/en/blog/red-hat-enterprise-linux-system-roles).
- [Administration and configuration tasks using System Roles in RHEL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/administration_and_configuration_tasks_using_system_roles_in_rhel)
