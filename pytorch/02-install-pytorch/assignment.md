---
slug: install-pytorch
id: tzqhrlkxronf
type: challenge
title: Install PyTorch
notes:
- type: text
  contents: In this step, you will create a Conda environment and install the necessary
    components for PyTorch.
tabs:
- id: wsfk2l2xh9zi
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
enhanced_loading: null
---
First, create a Conda environment for PyTorch called `torch`. An environment is a way to separate files, packages, and dependencies between projects.

```bash,run
conda create --name torch python=3.9 -y
```

Then, activate the Conda environment using the following command:

```bash,run
conda activate torch
```
Your prompt should reflect `torch` as the newly activated Conda environment:
<pre class="file">
(torch) <span style="color:green;">root@rhel</span>:~#
</pre>
Next, we need to install the correct version of pytorch. We will use the CPU-only build of Pytorch because we are not using a GPU for ML on this system.
```bash,run
conda install -y -n torch pytorch torchvision torchaudio cpuonly -c pytorch
```

To verify that PyTorch has been successfully installed into our environent, check the path of the `python3` executable.
```bash,run
which python3
```

Run the following in-line Python code to test that PyTorch is running correctly.
```bash,run
python3 -c "import torch; t1 = torch.tensor([1, 2, 3, 4]); t2 = torch.tensor([5, 6, 7, 8]); print(torch.add(t2, t1))"
```

The output should look like this:
<pre class="file">
tensor([ 6, 8, 10, 12])
</pre>

