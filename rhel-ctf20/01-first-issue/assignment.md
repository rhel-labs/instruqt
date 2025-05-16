---
slug: first-issue
id: ptejbxw1rnbs
type: challenge
title: The website is down
notes:
- type: text
  contents: |-
    Awww man.

    We have some N00B named **Nate** who just joined the team.  He totally messed up our production web server because he downloaded some ansible playbooks to **harden** our servers, but had no idea what they actually did.

    Now we need to fix the damage, but have no idea what happened, can you help?


    Good luck!
    (you'll need it, man that Nate guy...)
tabs:
- id: ji2cxylifvcf
  title: Terminal
  type: terminal
  hostname: rhel
- id: cue01nsasdlk
  title: System Website
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: basic
timelimit: 3120
enhanced_loading: null
---
Ugh, the system's website is down.  Check it out:

```
curl http://localhost
```

(or you can use the `System Website` tab in the interface there above the terminal)

See how it's the test page?
**THAT'S NOT RIGHT**

I don't know what **Nate** did, but please fix it, we've got all those people out there that need some web content and all they're getting is garbage.  We need them to see our super awesome site!

If you need to check the site again, you can use curl (above) or on the `System Website` tab there's a little arrow-circle-reload-thing on the right-side above the rendered website.

Above this instructions pane is the amount of time you have left before time runs out and this environment is destroyed.

