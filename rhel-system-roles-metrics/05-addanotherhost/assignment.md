---
slug: addanotherhost
id: 1zyvs3cktv8b
type: challenge
title: Add another host to be monitored
teaser: We'll add another host to be monitored collected and monitored by the Grafana
  host.
notes:
- type: text
  contents: Configure a playbook to install PCP on a new host and configure it to
    be collected and monitored by the Grafana host.
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
timelimit: 1
---

So far we have configured 2 RHEL hosts (`rhel2`, `rhel3`) to be monitored and have their performance metrics collected by host running Grafana and Redis (`rhel`). We'll now edit the play book to configure and add another host `rhel4`. This exercise is useful as you add more and more hosts to your datacenter.

The following configuration file will install PCP on the host `rhel4`. As well, it will tell the `rhel` Grafana host to monitor `rhel4`, in addition to the other hosts. Copy and paste this to the cli and press enter.

```bash
tee ~/metrics/inventory.yml << EOF
all:
  children:
    servers:
      hosts:
        rhel2:
        rhel3:
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
        firewall:
          - service: grafana
            state: enabled
        metrics_graph_service: yes
        metrics_query_service: yes
        metrics_retention_days: 7
        metrics_monitored_hosts:  "{{ groups['servers'] }}"
EOF
```

You may notice the only change made has been to add `rhel4` to this section:

```yaml
all:
  children:
    servers:
      hosts:
        rhel2:
        rhel3:
        rhel4:
```

You may ask yourself why we did not remove the originally configured hosts or the Grafana configuration. The reason is because RHEL System Roles are based on Ansible. Ansible playbooks are designed to be run multiple times ensuring that the same result is obtained on each target host. Therefore, running the playbook multiple times on the same hosts should obtain the same result on each host.

Run the playbook with the following command to execute the modified playbook.

```bash
ansible-playbook ~/metrics/metrics.yml -b -i ~/metrics/inventory.yml
```

Now go back to the Grafana dashboard.

Refresh the dashboard page on your browser.

You should be able to see `rhel4` has been added and metrics are being collected.

![rhel4](../assets/rhel4.png)

Congratulations on completing this lab!

For more information on RHEL System Roles, please consider browsing the following:

- [Automate performance metrics collection and visualization with RHEL System Roles](https://www.redhat.com/en/blog/automate-performance-metrics-collection-and-visualization-rhel-system-roles)
- [Red Hat Enterprise Linux System Roles blog series](https://www.redhat.com/en/blog/red-hat-enterprise-linux-system-roles).
- [Administration and configuration tasks using System Roles in RHEL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/administration_and_configuration_tasks_using_system_roles_in_rhel)
