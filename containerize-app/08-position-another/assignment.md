---
slug: position-another
id: itk74ew8goge
type: challenge
title: Position application content
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Next you will pull down our application content from github and position it within the container image.


First, clone the application content from github.  For our example, we are using a javascript based web application.

```bash
git clone https://github.com/ellisonleao/clumsy-bird
```

<pre class="file">
Cloning into 'clumsy-bird'...
remote: Enumerating objects: 1385, done.
remote: Total 1385 (delta 0), reused 0 (delta 0), pack-reused 1385
Receiving objects: 100% (1385/1385), 4.38 MiB | 8.88 MiB/s, done.
Resolving deltas: 100% (693/693), done.
</pre>

From the above output, you can see that the clone has been successful and in the current directory, you should now see a directory called `clumsy-bird` that contains the javascript based application.

Now, you will position this software within the container image you are building.

```bash
buildah copy ubi-working-container-1 clumsy-bird /var/www/html
```

<pre class="file">
63420a965b06ceaa3d61df013d51e0111d991f8b811c2df0164b649035543af3
</pre>

At this point, all the software needed for the container is in the image contents.  You can commit hte working container to a new container image called `clumsy-bird`.

```bash
buildah commit ubi-working-container-1 clumsy-bird
```

<pre class="file">
Getting image source signatures
Copying blob b38cb9259677 skipped: already exists
Copying blob 23e15b9ab3f0 skipped: already exists
Copying blob 2c59484e143a done
Copying config d0488a0d62 done
Writing manifest to image destination
Storing signatures
d0488a0d624ce5f411d970f22739f267f2cb4074062d5eb07b466f899f02fc86
</pre>
