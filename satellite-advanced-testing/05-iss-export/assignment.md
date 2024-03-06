---
slug: iss-export
id: yl3gfimkdmll
type: challenge
title: Inter-Satellite-Sync Export Sync
teaser: Transfer software between satellite servers.
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: Satellite Server 2
  type: terminal
  hostname: satellite-2
- title: Satellite Web UI
  type: external
  url: https://satellite-2.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
difficulty: ""
---

Custom Repository

```
tee ~/uploadfile.yml << EOF
---
- name: Create a custom product, a custom repository, and upload an RPM.
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Upload a file"
    redhat.satellite.content_upload:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      src: "kepler-0.7.7-1.x86_64.rpm"
      repository: "My custom repository"
      product: "My custom product"
      organization: "Acme Org"
```

Copy and paste the following playbook into the `Satellite Server` terminal.

```

```


