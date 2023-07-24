---
slug: insights
id: ymggfgmqgy55
type: challenge
title: Insights, and the Hybrid Cloud Console
tabs:
- title: Red Hat Hybrid Cloud Console
  type: external
  url: https://cloud.redhat.com
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
>_NOTE:_ To make the inline images larger, expand this window.
![Menu Slider](../assets/slider.png)

In the pane on the left, where your terminal was, you should now have a button to launch the Hybrid Cloud Console in an external window.  Press the button. You will then need to login with the following credentials.

Login:

```bash
rhel-df93
```

Password:

```bash
Redhat1!
```
![Red Hat Login screen](../assets/cloud-console-login.png)

![Red Hat Password screen](../assets/cloud-console-login-pass.png)

Once you are logged in using the credentials provided above, navigate to _RHEL_ inside the _Red Hat Insights_ box.

![cloud.redhat.com Homepage](../assets/RHEl_insights_select.png)

Now, if you click on the Inventory menu item on the left side, you'll see a list of systems registered to insights for this lab account.  Search for your lab host using the `Filter by name` search box at the top of the inventory list.

![Insights Inventory Filter](../assets/insights-inv-filter.png)

If you click on your system in the list, you will be brought to that hosts detail page.

You can see the amount of information that insights is able to report to you about your system under the general tab.

Head over to the Advisor tab, and we'll see if the Advisor service has any recommendations for our system.

![Insights Advisor Inventory Tab](../assets/insights-advisor-inv.png)

You can see that our system has a few recommendations.  The Remediation column tells us whether Insights can remediate these via a playbook, or if they need to be remediated manually.  In this example the first item in the list could be remediated via a playbook.

![Insights Advisor Recommendations](../assets/advisor-recommendations.png)

Next we'll look at the Vulnerability tab.

