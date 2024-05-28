---
slug: stress
id: lpwibzwpvkmh
type: challenge
title: Stress test RHEL hosts and monitor the results in Grafana.
teaser: Run the `stress` utility and view the results in Grafana.
notes:
- type: text
  contents: Run the `stress` utility on `rhel2` and `rhel3`. Then view the results
    in Grafana on `rhel`.
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
difficulty: basic
timelimit: 1
---
Run a stress test
===
Let's run a stress test on `rhel2` and `rhel3`

Click on this button [button label="rhel2"](tab-1) to switch to the `rhel2` terminal tab.

![rhel2](../assets/rhel2tab.png)

Run the following command.

```bash,run
stress --cpu 16 --io 3 --vm 5 --vm-bytes 128M --timeout 60s
```

`stress` is a utility for generating artificial loads on cpu, memory, and disk. You can play around with the `--cpu`, `--io`, and `--vm` flags to generate different loads. `--timeout` specifies the duration of the test.

Click on  this button [button label="rhel3"](tab-2) to switch to the `rhel3` terminal tab.

Run the  `stress` command as above to generate an artificial load.
```bash,run
stress --cpu 16 --io 3 --vm 5 --vm-bytes 128M --timeout 60s
```

When these `stress` tests are complete, go back to the Grafana dashboard and view the performance metrics of the `rhel2` and `rhel3` hosts. The dashboards might take a minute or two to update.

You can also experiment with the dash board scales and intervals.

![dash](../assets/scales.png)
