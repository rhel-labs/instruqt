---
slug: setup
id: k5n2v5hadqvt
type: challenge
title: Staging a new update
notes:
- type: text
  contents: |-
    There's an update coming for the new website to advertise a spring sale. Once the dev team is ready, we'll need to deploy the update to production. We've been using image mode for RHEL on this host to make updating the website and the OS simpler.

    # Goal

    Deploy the updated image to the production system offline, so we can schedule a maintenance window for the reboot with the marketing team.
tabs:
- id: fkztzyune9sx
  title: Builder
  type: terminal
  hostname: builder
  cmd: /bin/bash
- id: axs0bh7tytcx
  title: Webserver
  type: terminal
  hostname: builder
  cmd: ssh webserver
difficulty: ""
enhanced_loading: null
---
The developers just finished up the emergency release of the website for the launch of the new spring sale. The new bootc update image was just pushed into the registry.

For now,   **stage** the update on the webserver.

Then go ahead and take lunch! When we get the go ahead from all the other business units involved in the launch, we can schedule a window to reboot the system and have the new site ready.

Just **don't reboot the webserver** during business hours...

Click "Check" when you're ready to go to lunch