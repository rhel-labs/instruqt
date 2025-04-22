---
slug: network
id: vvyn06qu8ioy
type: challenge
title: Network Configuration and Troubleshooting
teaser: Learn how Command Line Assistant can help configure and troubleshoot networking
  on your system.
tabs:
- id: nz5rrydnhp6x
  title: rhel
  type: terminal
  hostname: rhel
difficulty: ""
enhanced_loading: null
---

```bash,run
c "how do I configure the dns server to 8.8.8.8 from the command line?"
```

```bash,run
c "how do I forward requests to port 9000 to 80"
```

```bash,run
firewall-cmd --zone=trusted --add-forward-port=port=9000:proto=tcp:toport=80 --permanent
```

```bash,run
firewall-cmd --reload
```

```
bash,run
curl http://rhel.urzopi8r911g.instruqt.io:9000/test.html
```
