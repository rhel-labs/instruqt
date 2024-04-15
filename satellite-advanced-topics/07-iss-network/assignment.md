---
slug: iss-network
id: 1h0xggggdf7p
type: challenge
title: Inter-Satellite Sync Network Sync
teaser: Configure ISS Network Sync
notes:
- type: text
  contents: ISS network sync is useful for configuring satellite server to obtain
    software indirectly from the internet through another satellite server.
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
- title: Satellite 2 Web UI
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

Inter-Satellite Sync (ISS) network sync enables a downstream satellite server to synchronize data from an upstream satellite server instead of the Red Hat content delivery network (CDN). The benefit of this feature is simplifying environments where network separation is required to segregate infrastructure from direct connections to the internet. ISS network sync is useful where DMZ topologies are required.

ISS network sync configuration consists of the following.
1) An upstream satellite server (`satellite.lab`) synchronizing software from the Red Hat CDN.
2) A downstream satellite server (`satellite-2.lab`) configured to synchronize software from `satellite.lab`.

The downstream satellite server must contain a manifest with valid Red Hat subscriptions.

Import the ssl certificate from satellite.lab
=============================================

In order to secure the synchronization process between upstream and downstream satellite servers, we need to import the upstream (`satellite.lab`) SSL certificate into the downstream satellite server (`satellite-2.lab`).

Enter the following command into the `Satellite Server 2` terminal.

```
wget -P ~ http://satellite.lab/pub/katello-server-ca.crt
```
This command will download the `katello-server-ca.crt` from `satellite.lab` to `satellite-2.lab`.

Next, in the `Satellite Server 2` terminal, use the following command to import the certificate.

```
hammer content-credential create \
--content-type cert \
--name "satellite.lab" \
--organization "Acme Org" \
--path ~/katello-server-ca.crt
```

Configure the downstream satellite server to use the upstream satellite server as a CDN
=======================================================================================

In the `Satellite Server 2 Web UI`, log in with the following credentials.

Username
```
admin
```

Password
```
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

Make sure that the organization is set to `Acme Org` and the location is set to `Kicking Horse`.

![](../assets/organdloacation.gif)

Navigate to `Subscriptions`.

![](../assets/subscriptions.png)

Click `Manage Manifest`.

![](../assets/managemanifest.png)

Click the tab `CDN Configuration`.

![](../assets/cdnconfig.png)

Click `Network Sync`.

![](../assets/networksync.png)

Perform the following tasks.
1) Enter the url for satellite.lab.
```
https://satellite.lab
```
2) Enter the username `admin`.
```
admin
```
3) Enter the following password.
```
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```
4) Enter the organization `Acme_Org`
```
Acme_Org
```
5) Choose the SSL CA Content Credential `satellite.lab`.
6) Click `Update`.
7) Click `Close`.

![](../assets/networksyncconfig.png)

Verify that satellite-2.lab can synchronize software from satellite.lab
=======================================================================

Navigate to the `Red Hat Repositories` menu.

![](../assets/redhatrepositories.png)

Click on the `Recommended Repositories` slider to change it to `ON`.

![](../assets/recommendedrepos.png)

Select the `Red Hat Enterprise Linux 9 for x86_64 - BaseOS RPMs 9` repository.

![](../assets/selectrhel9baseos.gif)

It is possible to select this repository because it has been provided by the upstream satellite server `satellite.lab`.

If we select another repository that hasn't been synchronized, a message would display `No repositories available`.

![](../assets/norepoavailable.gif)

Navigate to the Products menu.

![](../assets/products.png)

Sync all the products.

![](../assets/syncproducts.gif)

Optional self-directed exercise for the reader
================================

Deregister rhel1.lab from satellite.lab and register it to satellite-2.lab and install software.