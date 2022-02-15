---
slug: step4
id: swbwz459ztry
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: cloud.redhat.com
  type: website
  url: https://cloud.redhat.com
  new_window: true
difficulty: basic
timelimit: 900
---
# Reviewing system Insights

After selecting your system from the Inventory page and reviewing some overall data about it, click on the _Advisor_ tab to view the recommendations that apply to this host.

![Host Insights](../assets/host-homepage-new.png)

There are several recommendations offered for this system.  Scroll down through the list until you reach the one entitled _The mssql-server service will fail to start when the ownership or group of Microsoft SQL Server directory /var/opt/mssql is not correct_

From the _Detected issues_ section of the recommendation, you can see that this Insight is being triggered by the machine running Microsoft SQL Server with incorrect ownership or group of /var/opt/mssql.

In the _Steps to resolve_ section of the recommendation, there is a command to fix the issue. We will fix this in the next step.
