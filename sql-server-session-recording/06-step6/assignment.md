---
slug: step6
id: 52e6bmkorsvc
type: challenge
title: Step 6
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 900
---
## Configuring auditing in SQL Server

Auditing an instance of the SQL Server Database Engine or an individual database involves tracking and logging events that occur on the Database Engine. SQL Server audit lets you create server audits, which can contain server audit specifications for server level events, and database audit specifications for database level events. Audited events can be written to the event logs or to audit files.

Before we connect into SQL Server, let's create the folders to store the audit files

```bash
mkdir /var/opt/mssql/data/audit
```

Next, let's change ownership of the folder to the mssql user

```bash
chown mssql:mssql /var/opt/mssql/data/audit
```

Now, let's open up the sqlcmd shell prompt connected to the master database. The master database contains all of the system level information for SQL Server. It gets created when the server instance of SQL Server is created.

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -d master -N -C
```

Use master database to create a server audit specification

```sql
CREATE SERVER AUDIT AuditDataAccess TO FILE ( FILEPATH ='/var/opt/mssql/data/audit' ) WITH ( QUEUE_DELAY = 0,  ON_FAILURE = CONTINUE) WHERE object_name = 'SensitiveData'
```

The GO keyword is the default batch terminator in SQL Server, allowing a set of commands to run as a batch.

```sql
GO
```

Enable the server audit.

```sql
ALTER SERVER AUDIT AuditDataAccess WITH (STATE = ON)
```

```sql
GO
```

Next, let's create our table objects and database audit specification in our TestDB database.

Create a database called TestDB and the schema for our objects.

```sql
CREATE DATABASE TestDB
```

```sql
GO
```

Change context to use TestDB database.

```sql
USE TestDB
```

```sql
GO
```

```sql
CREATE SCHEMA DataSchema
```

```sql
GO
```

Create the database tables

```sql
CREATE TABLE DataSchema.GeneralData (ID int PRIMARY KEY, DataField varchar(50) NOT NULL)
```

```sql
GO
```

```sql
CREATE TABLE DataSchema.SensitiveData (ID int PRIMARY KEY, DataField varchar(50) NOT NULL)
```

```sql
GO
```

Enable the database audit corresponding to the server audit

```sql
CREATE DATABASE AUDIT SPECIFICATION [FilterForSensitiveData] FOR SERVER AUDIT [AuditDataAccess] ADD (SELECT, INSERT ON DataSchema.SensitiveData by public) WITH (STATE = ON)
```

```sql
GO
```

Insert into sensitive data table

```sql
INSERT into DataSchema.SensitiveData values (1, '1234')
```

```sql
GO
```

Select from sensitive data table

```sql
SELECT * from DataSchema.SensitiveData
```

```sql
GO
```

Check for audit records

```sql
SELECT @@spid, session_id, statement FROM fn_get_audit_file('/var/opt/mssql/data/audit/*.sqlaudit',default,default)
```

```sql
GO
```

Verify that the output has 2 records indicating that INSERT, and SELECT statements were executed against the SensitiveData table

<pre class="file">
<< OUTPUT ABRIDGED >>

<active-session-id>  <session-id> INSERT into DataSchema.SensitiveData values (1, '1234')
<active-session-id>  <session-id> SELECT * from DataSchema.SensitiveData

<< OUTPUT ABRIDGED >>
</pre>

You can exit the sqlcmd shell using the exit statement

```sql
exit
```
