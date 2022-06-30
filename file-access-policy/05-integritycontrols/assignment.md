---
slug: integritycontrols
id: z2ean27fq0nt
type: challenge
title: Configure fapolicyd integrity controls
teaser: Configure fapolicyd integrity controls
notes:
- type: text
  contents: Configure fapolicyd integrity controls
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 4
---
To mitigate situations where a trusted binary is substituted, fapolicyd supports different types of file integrity:

* File-size checking - this is a very fast method of integrity checking, where fapolicyd verifies that the file is the correct size before allowing execution
* Comparing SHA-256 hashes - computing and checking SHA-256 checksums is more secure than file-size checking, but does have an impact on system performance.
* Integrity Measurement Architecture (IMA) subsystem - IMA can be used by fapolicyd to support file integrity checks.

For this scenario we're going to use SHA-256 hashes to verify file integrity. This provides a good balance between speed and security, and is simple to setup and maintain.

You can configure integrity in the `/etc/fapolicyd/fapolicyd.conf` file:

```bash
sudo sed -i 's/integrity.*/integrity = sha256/' /etc/fapolicyd/fapolicyd.conf
```

Restart the daemon:

```bash
sudo systemctl restart fapolicyd
```

We can now verify whether file integrity checking is performed:

```bash
/bin/more "mooooooo"
```

Success! We've now mitigated the risk of an attacker hijacking a trusted binary on the system, by configuring fapolicyd integrity controls.
