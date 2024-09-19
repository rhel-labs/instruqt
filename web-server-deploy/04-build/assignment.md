---
slug: build
id: w3up4xo0d3ow
type: challenge
title: Deploying a web application
tabs:
- id: guux8tuwa3qu
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: nxxsjyeozzuw
  title: Website
  type: service
  hostname: rhel
  port: 80
- id: a1jxu1c2fulv
  title: Clumsy Bird
  type: service
  hostname: rhel
  path: /clumsy-bird
  port: 80
  new_window: true
difficulty: ""
timelimit: 1
---
Web server's can also host web-based applications.

Download a javascript based application and position it on your web server.
```bash,run
cd /var/www/html; git clone https://github.com/ellisonleao/clumsy-bird
```

<pre class="file">
Cloning into 'clumsy-bird'...
remote: Enumerating objects: 1385, done.
remote: Total 1385 (delta 0), reused 0 (delta 0), pack-reused 1385
Receiving objects: 100% (1385/1385), 4.38 MiB | 8.88 MiB/s, done.
Resolving deltas: 100% (693/693), done.
</pre>

If you are interested, you can look at the content you just downloaded to your webserver from github.

```bash,run
ls /var/www/html/clumsy-bird
```

Javascript is a language that runs on the web client's computer.  By switching to the <b>Clumsy Bird</b> tab at the top of the lab interface, you will see the code you deployed on the web server be executed by your system's web browser and rendered into this small video game.