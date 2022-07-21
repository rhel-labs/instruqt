---
slug: configuration
id: dvq6gaxcphzv
type: challenge
title: Configure the playbook.
teaser: We'll configure the playbook to configure the Metrics role by writing a series
  of configuations yaml files.
notes:
- type: text
  contents: We'll configure the playbook to configure the Metrics role by writing
    a series of configuations yaml files.
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
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: RHELs Web Console
  type: external
  url: https://rhels.${_SANDBOX_ID}.instruqt.io:9090
- title: RHEL3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
- title: RHEL Grafana Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
difficulty: basic
timelimit: 60
---

Let's create an inventory file

```bash
mkdir -p metrics/group_vars
```

```bash
tee -a ~/metrics/inventory.yml << EOF
all:
  children:
    servers:
      hosts:
        rhel2:
        rhel3:
      vars:
        firewall:
          - service: pmcd
            state: enabled
    metrics_monitor:
      hosts:
        rhel:
      vars:
        firewall:
          - service: grafana
            state: enabled
EOF
```

```bash
tee -a ~/metrics/group_vars/servers.yml << EOF
metrics_retention_days: 7
EOF
```

```bash
tee -a ~/metrics/group_vars/metrics_monitor.yml << EOF
metrics_graph_service: yes
metrics_query_service: yes
metrics_retention_days: 7
metrics_monitored_hosts:  "{{ groups['servers'] }}"
EOF
```

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
    - redhat.rhel_system_roles.firewall
EOF
```

```bash
cd metrics
ansible-playbook metrics.yml -b -i inventory.yml
```

![metrics completed](../assets/metrics_success.png)
