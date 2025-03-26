---
slug: challenge
id: vttix7sowwrc
type: challenge
title: Tricky permissions.
notes:
- type: text
  contents: |
    # Tricky permissions.

    How are you at user permissions?  We've got a fun one for you.

    In /srv, there are sub-directories.  One for Sales, and the other for Payroll

    There are several users on this system.
    * Matt and Lin work in Payroll
    * Nate and Paul work in Sales
    * Scott and Alice are both management level

    Can you make the following scenario work?
    * The Managers need read access to both /srv/payroll and /srv/sales
    * The Sales team needs read and write access to /srv/sales, but no access to /srv/payroll
    * The Payroll folks need read and write access to /srv/payroll, but no access to /srv/sales
tabs:
- id: qsrbjegxqerk
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # Tricky permissions.

  How are you at user permissions?  We've got a fun one for you.

  In /srv, there are sub-directories.  One for Sales, and the other for Payroll

  There are several users on this system.
  * Matt and Lin work in Payroll
  * Nate and Paul work in Sales
  * Scott and Alice are both management level

  Can you make the following scenario work?
  * The Managers need read access to both /srv/payroll and /srv/sales
  * The Sales team needs read and write access to /srv/sales, but no access to /srv/payroll
  * The Payroll folks need read and write access to /srv/payroll, but no access to /srv/sales