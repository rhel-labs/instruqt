---
slug: validate
id: 1kn3jhyk5z36
type: challenge
title: Validate the environment
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to use, modify, and
    troubleshoot changes to Red Hat Enterprise Linux's system-wide cryptographic
    policy.  The scenario uses the Apache web server as the example application.

    # Concepts included in this scenario:
    * Verify the current system-wide cryptographic policy setting
    * Change the current cryptographic policy setting
    * Troubleshoot applications after a cryptographic policy update
    * Modify application settings to comply with stronger cryptographic policies

    # Example Use case:
    Your security team requires using stronger cryptography algorithms with
    applications and is no longer allowing weaker algorithms, such as SHA-1.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
---
Using the provided system terminal session, validate the initial environment.

First, verify the current system-wide cryptographic policy.

```bash
update-crypto-policies --show
```

<pre class="file">
DEFAULT
</pre>

The default configuration on Red Hat Enterprise Linux for the system-wide
cryptographic policy (sometimes referred to as "crypto policy") is a
policy named `DEFAULT`.

Secure Socket Layer (SSL) is one of the cryptography methods managed by
the system-wide cryptography policy.  Throughout the exercise, you will
work with Apache as it is a service that utilizes SSL.  Hence, changes
to how SSL is managed will potentially impact those services that utilize
those cryptography frameworks.

Verify that Apache is running on the machine.

```bash
systemctl status httpd.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

active (running) since Tue 2023-07-11 16:47:31 UTC; 11s ago

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __active (running)__.

By default, Apache stores the automatically created, SSL self-signed
certificate at /etc/pki/tls/certs/localhost.crt. Verify the length of the
RSA public key used by the automatically created, self-signed SSL certificate
file.

```bash
openssl x509 -in /etc/pki/tls/certs/localhost.crt -text | grep bit
```

<pre class="file">
                RSA Public-Key: (2048 bit)
</pre>

By default, Apache uses a certificate with a 2048 bit public key.

Use `openssl` to connect to Apache on the https port (443).  As part of this
connection, openssl will receive a copy of the certificate to encrypt the
connection with the service.  You will verify that a client web browser is
utilizing the 2048 bit Public-Key certificate viewed above.

```bash
openssl s_client -connect localhost:443 </dev/null 2>/dev/null | grep '^Server public key'
```

<pre class="file">
Server public key is 2048 bit
</pre>

Client browsers are provided the 2048 bit key and SSL certificate by the
Apache service to encrypt their connection.
