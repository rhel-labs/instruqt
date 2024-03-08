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

Inter-Satellite-Sync export sync exports software at the repository, content view, and lifecycle environment levels.

- create a new content view
- add "My custom repository" to it
- export the cv
- transfer to satellite-2
- import into satellite-2

```
tee ~/issexportcv.yml << EOF
---
- name: Create a new CV "ISS Export".
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Create ISS Export content view"
    redhat.satellite.content_view:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      name: "ISS Export"
      organization: "Acme Org"
      repositories:
        - name: 'My custom repository'
          product: 'My custom product'

  - name: "Publish and promote ISS Export to Library lifecycle environment"
    redhat.satellite.content_view_version:
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      content_view: "ISS Export"
      lifecycle_environments:
        - "Library"
EOF
```

```
ansible-playbook issexportcv.yml
```

Copy and paste the following playbook into the `Satellite Server` terminal.

```
tee ~/issexportcv.yml << EOF
---
- name: Create a new CV "ISS Export".
  hosts: localhost
  remote_user: root

  tasks:
  - name: "Export content view version (full)"
    redhat.satellite.content_export_version:
      content_view: "ISS Export"
      content_view_version: '1.0'
      username: "admin"
      password: "bc31c9a6-9ff0-11ec-9587-00155d1b0702"
      server_url: "https://satellite.lab"
      organization: "Acme Org"
      destination_server: "satellite-2.lab"
EOF
```

```
ls /var/lib/pulp/exports/Acme_Org/ISS_Export/1.0/
```

```
ansible-playbook issexportcv.yml
```

![](../assets/exportedcv.png)

```
ssh satellite-2.lab mkdir -p /var/lib/pulp/imports/myimport && scp /var/lib/pulp/exports/Acme_Org/ISS_Export/1.0/satellite-2.lab/*/* satellite-2.lab:/var/lib/pulp/imports/myimport
```

![](../assets/mvexportstosatellite2.png)

We need to change the ownership of the data we just exported to the `pulp` account and group. Switch to the `Satellite Server 2` terminal and enter the following command.

```
chown -R /var/lib/pulp/imports/myimport
```

