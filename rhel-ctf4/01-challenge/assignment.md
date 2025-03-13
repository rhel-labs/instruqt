---
slug: challenge
id: k7xkqlx7x95e
type: challenge
title: Restore my Database
notes:
- type: text
  contents: |
    # Restore my Database

    For this challenge, we've placed a database backup in `/tmp/database/backup.sql`, your task is to complete the following setup:
    * Get the database up and running under MariaDB
    * Make sure the database is named `businesscorp`
    * Create a user named `erpuser` with a password of `ErHE3zop`, with standard privileges (no grant, or administrative rights) with access to ONLY the `businesscorp` database. They should be able to read and write data to the database, but not delete the database, or add other privileges.
    * The database does not have to be accessible remotely, localhost is fine.
    * Set the local mysql `root` user's password to `9X2he9gK` so that authenticating to mariadb as the root user from the command line works with this password.
tabs:
- id: vb0hwqds2tz3
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Restore my Database

For this challenge, we've placed a database backup in `/tmp/database/backup.sql`, your task is to complete the following setup:
* Get the database up and running under MariaDB
* Make sure the database is named `businesscorp`
* Create a user named `erpuser` with a password of `ErHE3zop`, with standard privileges (no grant, or administrative rights) with access to ONLY the `businesscorp` database. They should be able to read and write data to the database, but not delete the database, or add other privileges.
* The database does not have to be accessible remotely, localhost is fine.
* Set the local mysql `root` user's password to `9X2he9gK` so that authenticating to mariadb as the root user from the command line works with this password.