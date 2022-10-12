---
slug: step2
id: ctt5tlturftm
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: OpenSCAP Report
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 1
---
# Displaying available profiles

You can display all available profiles in the datastream file using the *openscap info* command. For this lab, you will be using the RHEL8 datastream file.

```
oscap info /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml
```

The output has several profiles including PCI-DSS, [DRAFT] DISA STIG, and ACSC Essential Eight.

<pre class="file">
<< OUTPUT ABRIDGED >>
                Profiles:
                        Title: Protection Profile for General Purpose Operating Systems
                                Id: xccdf_org.ssgproject.content_profile_ospp
                        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat EnterpriseLinux 8
                                Id: xccdf_org.ssgproject.content_profile_pci-dss
                        Title: [DRAFT] DISA STIG for Red Hat Enterprise Linux 8
                                Id: xccdf_org.ssgproject.content_profile_stig
                        Title: Australian Cyber Security Centre (ACSC) Essential Eight
                                Id: xccdf_org.ssgproject.content_profile_e8
                Referenced check files:
                        ssg-rhel8-oval.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
                        ssg-rhel8-ocil.xml
                                system: http://scap.nist.gov/schema/ocil/2
                        security-data-oval-com.redhat.rhsa-RHEL8.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
<< OUTPUT ABRIDGED >>
</pre>

>__NOTE:__ Each profile in the output has a title which describes the profile and corresponding Id. For this lab, we are interested in the PCI-DSS profile, and the corresponding Id is *xccdf_org.ssgproject.content_profile_pci-dss*.

A profile contains generic security recommendations that apply to all Red Hat Enterprise Linux installations and additional security recommendations that are specific to the intended usage of a system. To obtain information about a specific profile, specify the profile Id using the *--profile* option.

```
oscap info --profile xccdf_org.ssgproject.content_profile_pci-dss /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml
```

<pre class="file">
Document type: Source Data Stream
Imported: 2020-02-11T08:41:17

Stream: scap_org.open-scap_datastream_from_xccdf_ssg-rhel8-xccdf-1.2.xml
Generated: (null)
Version: 1.3
WARNING: Datastream component 'scap_org.open-scap_cref_security-data-oval-com.redhat.rhsa-RHEL8.xml' points out to the remote 'https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL8.xml'. Use '--fetch-remote-resources' option to download it.
WARNING: Skipping 'https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL8.xml' file which is referenced from datastream
Profile
        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 8
        Id: xccdf_org.ssgproject.content_profile_pci-dss

        Description: Ensures PCI-DSS v3.2.1 security configuration settings are applied.
</pre>

>__NOTE:__ The datastream file makes references to remote OVAL content that is regularly updated. During scanning, OpenSCAP attempts to download the resources locally if *--fetch-remote-resources* option is provided.
