---
slug: grafana
id: mkrsr6f02ke5
type: challenge
title: Log in to Grafana.
teaser: Log in to Grafana.
notes:
- type: text
  contents: Log into Grafana.
tabs:
- id: cfhmranpyqkp
  title: AAP Web Console
  type: service
  hostname: aap
  port: 443
- id: jey2dgiis5jz
  title: AAP
  type: terminal
  hostname: aap
- id: 0chyrsswp04s
  title: rhel Grafana Web Console
  type: service
  hostname: rhel
  port: 3000
- id: vyyzdczuig7o
  title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- id: 4xbjnnhirqia
  title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
- id: 5lvxb7bgyyjr
  title: rhel3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---

In the previous challenge, we installed Grafana on `rhel` and PCP on `rhel2` and `rhel3`.

Click on the `rhel Grafana Web Console` tab.

![Grafana Tab](../assets/rhelgrafanawebconsole.png)

Log into Grafana with the following credentials.

Username

```text
admin
```

Password

```text
admin
```

![Grafana Login Menu](../assets/grafanaloginmenu.png)

Upon successful login, Grafana will ask you to change the password. Skip this for now by clicking on `Skip`.

![Skip password](../assets/skippassword.png)

Click on `Data Sources`.

![Data Sources](../assets/datasources.png)

Click on `PCP Redis`.

![pcp redis](../assets/pcpredis.png)

Click on `Save & Test`.

![save and test](../assets/savetest.png)

Here's what a successful result should look like.

![success](../assets/savetestsuccess.png)

Click on the `Dashboards` tab.

![dashboards tab](../assets/dashboardstab.png)

Click on `Import` next to the `PCP Redis: Host Overview` title bar.

![pcpredishostoverview](../assets/pcpredishostoverview.png)

![success](../assets/pcpredishostoverviewsuccess.png)

Click on `PCP Redis: Host Overview`.

![button](../assets/pcpredishostoverviewclick.png)

A dashboard showing the performance metrics for the `rhel` host will be displayed.

![result](../assets/dashboard.png)

You can see that only a small amount of data has been collected since the graph lines are short.

To view the performance metrics for the `rhel2` and `rhel3` host, click the `host` dropdown bar.

![dropdown](../assets/dropdown.png)
