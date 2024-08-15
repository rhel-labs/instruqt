---
slug: run-conversion-task
id: ukakw2vstosw
type: challenge
title: Run the conversion task
teaser: Run the conversion task to convert your host to Red Hat Enterprise Linux.
tabs:
- id: 5laib1nuqaqc
  title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
- id: xay44l4zrctb
  title: Red Hat Insights
  type: browser
  hostname: insights
difficulty: basic
---
Run the Convert2RHEL conversion task
====================================
<!-- Enable `Preview on`.

![preview on](../assets/enablepreview.png) -->

Run the Convert2RHEL conversion task.

![conversion task](../assets/conver2rhelconversiontask.png)

1. Click on `Tasks` under `Automation Toolkit`.
2. Under `Convert2RHEL`, click `Run task`.

Configure the task the following way.

![conversion attributes](../assets/conversionattributes.png)

1. Give your task the following name
```
Convert2RHEL task for [[ Instruqt-Var key="vmid" hostname="host" ]]
```
2. Select the host `[[ Instruqt-Var key="vmid" hostname="host" ]]`.
3. Click `Execute task`.

The conversion takes around 15 minutes to complete.

Checking the status of the task
===============================

Just as in the first challenge of this lab, there are 2 ways to check on the status of the task. The first is to read the `convert2rhel` logs on the `centos` host. The second is to view the status of the task in Insights.

To view the `convert2rhel` logs, enter the following in the cli of the `centos` host.

```
tail -f /var/log/convert2rhel/convert2rhel.log
```
![tail logs](../assets/viewlogs.png)

To view the status of the task in Insights, click on the `Activity` tab.

![activity tab](../assets/activitytab.png)

Click on the task you created. The name of the task is
```
Convert2RHEL task for [[ Instruqt-Var key="vmid" hostname="host" ]]
```

![task](../assets/conversiontask.png)

The conversion takes around 15 minutes to complete.

![task status](../assets/taskstatus.png)

Periodically click on the refresh button of the virtual browser to see if the task has finished.

![refresh](../assets/refreshstatus.png)

When the task has finished, you can view the results by clicking on the successfully completed task.
