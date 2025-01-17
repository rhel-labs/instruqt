---
slug: create-from-scratch
id: dxw52pb8igmv
type: challenge
title: Creating an application image from scratch
tabs:
- id: wd2vpqvpurcq
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "buildah-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Starting from an existing base container isn't the only option available to `buildah`.  `Buildah` can create a minimal container image that contains metadata and a filesystem stub.

To create this style of image use the `scratch` special target for `buildah from`.

```bash,run
buildah from scratch
```

<pre class="file">
working-container
</pre>

Since there's no starting image, the working container will be called `working-container`.

We can start working with the scratch container using tools on the host by mounting the container filesystem on the host using `buildah mount`.

> _NOTE:_ We capture the output of the `buildah` command in the variable *scratchmnt* to make it easier to work with the filesystem path in these exercises.

```bash,run
scratchmnt=$(buildah mount working-container)
```

```bash,run
echo ${scratchmnt}
```

<pre class="file">
/var/lib/containers/storage/overlay/5199b9cbf441fe93e3629f9d6336fd7008858b9b6e23629a724ccc2f567f3feb/merged
</pre>

Right now, that directory is empty.

```bash,run
ls -l ${scratchmnt}
```

<pre class="file">
total 0
</pre>
