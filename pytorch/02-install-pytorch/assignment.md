---
slug: install-pytorch
id: tzqhrlkxronf
type: challenge
title: Install TensorFlow
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
---
First, create a Conda environment for PyTorch called `torch`:

```bash
conda create --name torch python=3.9 -y
```

Then, activate the Conda environment using the following command:

```bash
conda activate torch
```
Your Conda environment status is shown in the command line withinin parentheses like this:
<pre class="file">
(torch) <span style="color:green;">root@rhel</span>:~#
</pre>
Next, we need to install the correct version of pytorch. We will use the CPU-only build of Pytorch because we are not using a GPU for ML on this system.
```bash
conda install -y -n torch pytorch torchvision torchaudio cpuonly -c pytorch
```

To verify that PyTorch is running properly on the CPU, run the following command to execute a simple test program:
```bash
python3 -c "import torch; t1 = torch.tensor([1, 2, 3, 4]); t2 = torch.tensor([5, 6, 7, 8]); print(torch.add(t2, t1))"
```

The output should look like this:
<pre class="file">
tensor([ 6, 8, 10, 12])
</pre>