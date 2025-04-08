---
slug: iop-advisor
id: kxwelgrorq1t
type: challenge
title: Use Insights advisor to analyze your systems
teaser: Use Insights advisor to detect and remediate configuration problems.
notes:
- type: text
  contents: Insights advisor is now available to Satellite systems that are disconnected
    from the internet. In this assignment we'll review how to view and remediate configuration
    problems with advisor.
tabs:
- id: dtxdo3pji6te
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: qocbcxwmngz6
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: u0yqgvpruskb
  title: rhel1
  type: terminal
  hostname: rhel1
- id: r6ntbqy1dcqu
  title: rhel2
  type: terminal
  hostname: rhel2
difficulty: ""
enhanced_loading: null
---

Red Hat Insights continuously analyzes platforms and applications to predict risk, recommend actions, and track costs so enterprises can better manage hybrid cloud environments.

Insights advisor analyzes Red Hat Enterprise Linux systems for configuration problems that could degrade performance or render your system less secure. Red Hat Satellite provides access to the Insights advisor service in a connected and disconnected network topology. In this assignment we'll review how to use Insights advisor in a disconnected environment to analyze problems and remediate automatically.

Review Insights advisor recommendations
===
Navigate to the `Recommendations` menu.

![](../assets/insights-recommendations.png)

In this menu we can see all the Insights advisor `Recommendations` for each host. Click on the "kebab" button to review the knowledge base article associated with an advisory.

![](../assets/recommendations.png)

Notice that each of these recommendations has an ansible playbook to remediate the the detected problem.

![](../assets/associated-playbook.png)

Automatically remediate the hosts
===

Let's remediate all the problems found by Insights advisor.
1) Select all recommendations.
2) Click `Remediate`.

![](../assets/remediate-all-advisories.png)

Review all the remediations and click `Remediate`.

![](../assets/review-all-remediate.png)

When all remediations have been applied, proceed to the next assignment.

![](../assets/successfully-remediated.png)