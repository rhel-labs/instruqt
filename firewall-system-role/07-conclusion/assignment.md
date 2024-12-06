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
- id: kncf6nzun9hn
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: zvivdjkmn4p3
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["lhvd4dcz5tlj","zvivdjkmn4p3"],"activeTabId":"lhvd4dcz5tlj","size":49}},{"leaf":{"tabs":["kncf6nzun9hn"],"activeTabId":"kncf6nzun9hn","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

For more details on using the firewall system role, please read this blog post: <https://www.redhat.com/en/blog/automating-firewall-configuration-rhel-system-roles>

If you have any comments or suggestions, please visit our github repo and:

- [Start a discussion](https://github.com/rhel-labs/instruqt/discussions)
- [Tell us your idea for a new lab or feature](https://github.com/rhel-labs/instruqt/discussions/categories/ideas)
- [Report an issue](https://github.com/rhel-labs/instruqt/issues)
