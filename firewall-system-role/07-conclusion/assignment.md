---
slug: conclusion
id: 4rqj6oybqy6p
type: challenge
title: Conclusion
tabs:
- id: lhvd4dcz5tlj
  title: controlnode
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing"
- id: kncf6nzun9hn
  title: rhelvm
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- id: zvivdjkmn4p3
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

For more details on using the firewall system role, please read this blog post: <https://www.redhat.com/en/blog/automating-firewall-configuration-rhel-system-roles>

If you have any comments or suggestions, please visit our github repo and:

- [Start a discussion](https://github.com/rhel-labs/instruqt/discussions)
- [Tell us your idea for a new lab or feature](https://github.com/rhel-labs/instruqt/discussions/categories/ideas)
- [Report an issue](https://github.com/rhel-labs/instruqt/issues)
