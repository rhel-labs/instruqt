---
slug: step2
id: 1cao1umadkxd
type: challenge
title: Step 2
tabs:
- id: 7qoyoe0sgypv
  title: Terminal
  type: terminal
  hostname: rhel
- id: rgkedwqfa8hj
  title: OpenSCAP Report
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Displaying available profiles

You can display all available profiles in the datastream file using the *openscap info* command. For this lab, you will be using the RHEL9 datastream file.

```bash,run
oscap info /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```

The output has several profiles including PCI-DSS, [DRAFT] DISA STIG, and ACSC Essential Eight.

<pre class="file">
<< OUTPUT ABRIDGED >>
                Profiles:
                        Title: ANSSI-BP-028 (enhanced)
                                Id: xccdf_org.ssgproject.content_profile_anssi_bp28_enhanced
                        Title: ANSSI-BP-028 (high)
                                Id: xccdf_org.ssgproject.content_profile_anssi_bp28_high
                        Title: ANSSI-BP-028 (intermediary)
                                Id: xccdf_org.ssgproject.content_profile_anssi_bp28_intermediary
                        Title: ANSSI-BP-028 (minimal)
                                Id: xccdf_org.ssgproject.content_profile_anssi_bp28_minimal
                        Title: CCN Red Hat Enterprise Linux 9 - Advanced
                                Id: xccdf_org.ssgproject.content_profile_ccn_advanced
                        Title: CCN Red Hat Enterprise Linux 9 - Basic
                                Id: xccdf_org.ssgproject.content_profile_ccn_basic
                        Title: CCN Red Hat Enterprise Linux 9 - Intermediate
                                Id: xccdf_org.ssgproject.content_profile_ccn_intermediate
                        Title: CIS Red Hat Enterprise Linux 9 Benchmark for Level 2 - Server
                                Id: xccdf_org.ssgproject.content_profile_cis
                        Title: CIS Red Hat Enterprise Linux 9 Benchmark for Level 1 - Server
                                Id: xccdf_org.ssgproject.content_profile_cis_server_l1
                        Title: CIS Red Hat Enterprise Linux 9 Benchmark for Level 1 - Workstation
                                Id: xccdf_org.ssgproject.content_profile_cis_workstation_l1
                        Title: CIS Red Hat Enterprise Linux 9 Benchmark for Level 2 - Workstation
                                Id: xccdf_org.ssgproject.content_profile_cis_workstation_l2
                        Title: [DRAFT] Unclassified Information in Non-federal Information Systems and Organizations (NIST 800-171)
                                Id: xccdf_org.ssgproject.content_profile_cui
                        Title: Australian Cyber Security Centre (ACSC) Essential Eight
                                Id: xccdf_org.ssgproject.content_profile_e8
                        Title: Health Insurance Portability and Accountability Act (HIPAA)
                                Id: xccdf_org.ssgproject.content_profile_hipaa
                        Title: Australian Cyber Security Centre (ACSC) ISM Official
                                Id: xccdf_org.ssgproject.content_profile_ism_o
                        Title: Protection Profile for General Purpose Operating Systems
                                Id: xccdf_org.ssgproject.content_profile_ospp
                        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 9
                                Id: xccdf_org.ssgproject.content_profile_pci-dss
                        Title: [DRAFT] DISA STIG for Red Hat Enterprise Linux 9
                                Id: xccdf_org.ssgproject.content_profile_stig
                        Title: [DRAFT] DISA STIG with GUI for Red Hat Enterprise Linux 9
                                Id: xccdf_org.ssgproject.content_profile_stig_gui
                Referenced check files:
                        ssg-rhel9-oval.xml
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
                        ssg-rhel9-ocil.xml
                                system: http://scap.nist.gov/schema/ocil/2
                        security-data-oval-v2-RHEL9-rhel-9.oval.xml.bz2
                                system: http://oval.mitre.org/XMLSchema/oval-definitions-5
<< OUTPUT ABRIDGED >>
</pre>

> [!NOTE]
> Each profile in the output has a title which describes the profile and corresponding Id. For this lab, we are interested in the PCI-DSS profile, and the corresponding Id is *xccdf_org.ssgproject.content_profile_pci-dss*.

A profile contains generic security recommendations that apply to all Red Hat Enterprise Linux installations and additional security recommendations that are specific to the intended usage of a system. To obtain information about a specific profile, specify the profile Id using the *--profile* option.

```bash,run
oscap info --profile xccdf_org.ssgproject.content_profile_pci-dss /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```

<pre class="file">
Document type: Source Data Stream
Imported: 2023-08-17T13:50:04

Stream: scap_org.open-scap_datastream_from_xccdf_ssg-rhel9-xccdf.xml
Generated: (null)
Version: 1.3
WARNING: Datastream component 'scap_org.open-scap_cref_security-data-oval-v2-RHEL9-rhel-9.oval.xml.bz2' points out to the remote 'https://access.redhat.com/security/data/oval/v2/RHEL9/rhel-9.oval.xml.bz2'. Use '--fetch-remote-resources' option to download it.
WARNING: Skipping 'https://access.redhat.com/security/data/oval/v2/RHEL9/rhel-9.oval.xml.bz2' file which is referenced from datastream
Profile
        Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 9
        Id: xccdf_org.ssgproject.content_profile_pci-dss

        Description: Ensures PCI-DSS v3.2.1 security configuration settings are applied.
</pre>

> [!NOTE]
> The datastream file makes references to remote OVAL content that is regularly updated. During scanning, OpenSCAP attempts to download the resources locally if *--fetch-remote-resources* option is provided.
