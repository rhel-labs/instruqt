---
slug: step7
id: awnjvcysvgx4
type: challenge
title: Step 7
tabs:
- id: yaxadudyq1of
  title: Terminal
  type: terminal
  hostname: rhel
- id: oak3h9wvuwre
  title: Terminal SQL Server
  type: terminal
  hostname: rhel
- id: cd4jgiqsecd3
  title: Terminal SQL Client
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Re-query In-Memory OLTP data in SQL Server

Launch an interactive bash shell in the *mssqlserver-restored* container -

```bash
podman exec -it mssqlserver-restored "/bin/bash"
```

> Let's find out the number of total sessions in the UserSession table

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT count(sessionID) FROM dbo.UserSession"
```

<pre class="file">
          6

(1 rows affected)
</pre>

> Let's find out the UserID of the user who has the highest total price items in their shopping cart

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT top 1 UserID FROM dbo.ShoppingCart order by TotalPrice desc"
```

<pre class="file">
UserID
-----------
        342

(1 rows affected)
</pre>

The T-SQL query answers on the restored container are same as the T-SQL query answers on the container before the checkpoint was taken.
