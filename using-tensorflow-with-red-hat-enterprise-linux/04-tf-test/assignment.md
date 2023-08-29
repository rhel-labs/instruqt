---
slug: tf-test
id: emfyf59imym2
type: challenge
title: Visualize your Work
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: Juypter Notebook
  type: service
  hostname: rhel
  port: 8888
  new_window: true
difficulty: basic
---
Click on the `Jupyter Notebook` tab near the top of the lab window. This will open your Jupyter Notebook in a new tab.

When presented with a login screen, enter `redhat` into the password box and click `Log in`.
![](../assets/jupyter-login.png)

When you reach the notebook's main menu, click on the check box to the left of `neural_network.ipynb`, and then click open.
![](../assets/neural_network_open.png)

First, take a look at the Jupyter Notebook. You'll notice that is structured as code surrounded by formatted text, offering context as to what the code is doing. In its current state, there is no visible output from your code. To view the output of your code, you will need to run the program.

To run all of the code, click on the button pictured below:
![](../assets/jupyter_play_neural.png)

Next, you will be prompted with a dialog box asking whether you wish to restart the kernel. Click `Restart`.
![](../assets/jupyter_run_all_neural.png)
The kernel will restart and your program will run. This will take about 20 seconds to finish.

Once the program has run, scroll through the Jupyter Notebook again. You should see output like this:
![](../assets/tf_numerical_output.png)
![](../assets/tf_model_test.png)

In the last part of your program's output, it selects 5 images and attempts to recognize them through the model you have trained during this lab.

To learn more about TensorFlow and learn how to use it in your own programs, check out the helpful tutorials here:
[https://www.tensorflow.org/tutorials](https://www.tensorflow.org/tutorials)

You have now successfully trained and tested a neural network in Red Hat Enterprise Linux. This concludes the lab, but feel free to explore further until the lab session expires.
