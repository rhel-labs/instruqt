---
slug: step6
id: nfvnqc9ybhz7
type: challenge
title: Step 6
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Connect to SQL Server and Query Data

Now, let's open up the sqlcmd shell prompt connected to the **pubs** database created by the ansible playbook in SQL Server.  A sample data set has been created for you in `InstPubs.sql`, we will import it in this step.

If you haven't changed the sa password in the previous step, you should be able to successfully execute the command below and run the script to install the pubs data in the testDB database.

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P p@55w0rD -N -C -i ./InstPubs.sql
```

Now that the data is loaded, let's query -

> How about finding the store name of the top performing store and the total sales for that store?

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P p@55w0rD -d pubs -N -C -Q "SELECT TOP 1 stores.stor_name as storename, sum(sales.qty) as sumqty FROM stores JOIN sales ON stores.stor_id = sales.stor_id GROUP BY stores.stor_id, stores.stor_name ORDER BY sumqty DESC"
```

<pre class="file">
storename                                sumqty
---------------------------------------- -----------
Doc-U-Mat: Quality Laundry and Books             130

(1 rows affected)
</pre>
