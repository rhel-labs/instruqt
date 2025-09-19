---
slug: regenerate
id: zlbylmjoyszo
type: challenge
title: Regenerate SSL certificates
tabs:
- id: uaofdn6mrw2e
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
To comply with the system-wide cryptographic policy of FUTURE, you will need
to generate a replacement SSL certificate using an RSA key of 3072 bit length,
or longer.

Before you create the updated SSL certificate, make a backup of your existing
certificate files.

```bash
cp /etc/pki/tls/private/localhost.key /etc/pki/tls/private/localhost.key.orig
```

```bash
cp /etc/pki/tls/certs/localhost.crt /etc/pki/tls/certs/localhost.crt.orig
```

Now that you have a backup of your original certificates, and could revert to
them if something unexpected happens, generate a new, replacement SSL
certificate and public key.  The new RSA certificate will use a public key
of of 3072 bits.

```bash
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:3072 -subj='/C=XX/O=Default' -keyout /etc/pki/tls/private/localhost.key -out /etc/pki/tls/certs/localhost.crt
```

Verify the bit-length of the key to confirm that it is 3072 bit.

```bash
openssl x509 -in /etc/pki/tls/certs/localhost.crt -text | grep bit
```

<pre class="file">
                RSA Public-Key: (3072 bit)
</pre>

Now that a new SSL certificate has been created using a larger public key,
it complies with the requirements of the  FUTURE cryptographic policy.

> **NOTE:** It is recommended practice to use Certificate Authority (CA) issued
certificates.  If you were using a certificate from a Certificate Authority,
you would need to generate a new Certificate Signature Request (csr) and
submit it to your CA.  When you receive the signed certificate from your CA,
you would then position it, and update any configuration files needed to
reference it.
