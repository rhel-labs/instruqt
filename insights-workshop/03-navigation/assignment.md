---
slug: navigation
id: ooam5wxh9ddj
type: challenge
title: Navigating the Insights service
tabs:
- id: wx7w6nwlmfxp
  title: Red Hat Insights
  type: browser
  hostname: insights
- id: en1ck68e8tzz
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---

Now that you have opened Red Hat Insights for Red Hat Enterprise Linux, you will see a summary dashboard of all systems registered to your organization.

![Insights Homepage](../assets/insights-homepage-v2.png)

For the purposes of this exercise, you are working with a single machine registered to Insights and we will focus on the Advisor recommendations available for that host.  Click on the _Inventory_ link on the left navigation bar. Then, click on _Systems_.

![Navigate to Inventory](../assets/insights-homepage-inventory-highlight.png)

Once you are on the Inventory page, find and click your hostname to pull up information for your individual machine.  Recall in a previous step you found your machine hostname with the `hostname` command.

![View your machine](../assets/inventory-homepage-v2.png)

>_NOTE:_ Your host may not be the first one listed, as depicted in the graphic above.  You may find it necessary to use the _Find system by name_ search function at the top of the list of hosts to more quickly find your system.

>_NOTE:_ If you do not see your host in the inventory list, it may be necessary to re-run the `insights-client` command on your RHEL host.