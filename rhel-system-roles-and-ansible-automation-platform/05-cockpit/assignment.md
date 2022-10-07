---
slug: cockpit
type: challenge
title: Log in to RHEL hosts.
teaser: Log in to RHEL hosts.
notes:
- type: text
  contents: Log in to the other RHEL hosts and examine the configurations made by RHEL System Roles.
tabs:
- title: AAP
  type: terminal
  hostname: aap
- title: AAP Web Console
  type: external
  url: https://aap.${_SANDBOX_ID}.instruqt.io
- title: rhel Grafana Web Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 60
---

You can also log into the hosts' web console to check that they have been enabled.

![web console tabs](../assets/webconsoletabs.png)

Use the following credentials.

### Username

```yaml
rhel
```

### Password

```yaml
redhat
```
