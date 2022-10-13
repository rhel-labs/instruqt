---
slug: step1
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario users will be able to create podman pods, create containers within those pods, and forward ports to the services those containers run.

    # Concepts included in this scenario:
    * Verify whether podman is installed on the system
    * Create a pod in podman
    * Run a container inside of a pod in podman
    * Forward ports to containers within pods.

    # Example Use case:
    An administrator wants to run a service on a podman container host, that has dependent services. 
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Validate the environment

>For this scenario, `container-tools` which contains podman and its depenencies, has already been installed on the system.

The feature we will be working with is specific to Podan version 4 and newer, so first let's check that podman 4.0.x is installed on the system.

```bash
podman --version
```

You should see the output below -

<pre class="file">
 # podman --version
podman version 4.0.2
</pre>

With podman verified, we can continue with the scenario.
