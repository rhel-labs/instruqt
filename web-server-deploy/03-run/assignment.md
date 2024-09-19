---
slug: run
id: pwjtvfk8xffx
type: challenge
title: Publishing your first web content
tabs:
- id: 0d1tqgz1buyw
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: qz1jpkqdyhw7
  title: Website
  type: service
  hostname: rhel
  path: /
  port: 80
- id: 567or8c8rftd
  title: Editor
  type: code
  hostname: rhel
  path: /var/www/html/index.html
difficulty: ""
timelimit: 1
---
Now that you have a functioning web server, you can make it more useful by having it serve your own content.

An html formatted file has been placed in the Document Root, the directory that holds webserver content.
Please update the file to make it into a page that is more unique about you.

Click the following button: [button label="Editor"](tab-2) tab.

The editor will automatically save changes.

After editing the file, move to the [button label="Website"](tab-1) tab. You should see your updated website content.  If it still displays the test page, please use the refresh button to get the browser to refresh the site content.
