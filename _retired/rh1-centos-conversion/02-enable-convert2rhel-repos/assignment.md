---
slug: enable-convert2rhel-repos
id: gpz685jv20qj
type: challenge
title: Enable the convert2rhel repositories
teaser: Enable the convert2rhel repositories.
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
- title: Red Hat Insights
  type: browser
  hostname: insights
difficulty: basic
---
The Convert2RHEL RPM is an offical Red Hat package. Therefore it is readily availble from the Red Hat software repository (CDN). As your CentOS server is not subscribed to the Red Hat CDN, you will need to enable the Convert2RHEL repository.

Download the SSL certificate.

```bash
curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem

```

<pre class='file'>
# curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7411  100  7411    0     0  15260      0 --:--:-- --:--:-- --:--:-- 15280
</pre>

Download the convert2rhel repository file.

```bash
curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo

```

<pre class='file'>
# curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   247  100   247    0     0    509      0 --:--:-- --:--:-- --:--:--   510
</pre>

Proceed to the next step.