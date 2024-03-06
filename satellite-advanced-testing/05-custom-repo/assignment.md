---
slug: custom-repo
id: 7zemzf9x3ozf
type: challenge
title: Share a custom software repository
teaser: Share software through a custom repository.
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
