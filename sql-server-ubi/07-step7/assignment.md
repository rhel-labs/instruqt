---
slug: step7
id: gsgahfsjy0mq
type: challenge
title: Step 7
tabs:
- id: gagxyig3bluu
  title: Terminal
  type: terminal
  hostname: rhel
- id: rvxyau53oitz
  title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
- id: it8awvd2oycj
  title: Visual Editor
  type: code
  hostname: rhel
  path: /root
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Re-query In-Memory OLTP data in SQL Server

Launch an interactive bash shell in the *mssqlserver-restored* container -

```
podman exec -it mssqlserver-restored "/bin/bash"
```

> Let's find out the number of total sessions in the UserSession table

```
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT count(sessionID) FROM dbo.UserSession"
```

<pre class="file">
          6

(1 rows affected)
</pre>

> Let's find out the UserID of the user who has the highest total price items in their shopping cart

```
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT top 1 UserID FROM dbo.ShoppingCart order by TotalPrice desc"
```

<pre class="file">
UserID
-----------
        342

(1 rows affected)
</pre>

The T-SQL query answers on the restored container are same as the T-SQL query answers on the container before the checkpoint was taken.
