---
slug: step3
id: ooam5wxh9ddj
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 900
---
# Navigating the Insights service

Now that you have opened Red Hat Insights for Red Hat Enterprise Linux, you
will see a summary dashboard of all systems registered to your organization.

![Insights Homepage](../assets/insights-homepage-v2.png)

For the purposes of this exercise, you are working with a single machine
registered to Insights and we will focus on the Advisor recommendations
available for that host.  Click on the _Inventory_ link on the left
navigation bar.

![Navigate to Inventory](../assets/insights-homepage-inventory-highlight.png)

Once you are on the Inventory page, find and click your hostname to pull up
information for your individual machine.  Recall in a previous step you
found your machine hostname with the `hostname` command.

![View your machine](../assets/inventory-homepage-v2.png)

>_NOTE:_ Your host may not be the first one listed, as depicted in the graphic above.  You may find it necessary to use the _Find system by name_ search function at the top of the list of hosts to more quickly find your system.
