---
slug: intro
id: 
type: challenge
title: Intro, and some background
notes:
- type: text
  contents: |
    # Introduction
    After completing this lab, you will have some introductory experience with several container management technologies included in Red Hat Enterprise Linux, Including
    * Podman
    * Multi-container pods
    * Controling podman entities with SystemD through Quadlet
    * Deploying containers and pods using RHEL System Roles
    
    These skills are useful for deploying containers that do not require a heavier container orchestration system, but still require a production level of service.

tabs:
- id: 
  title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
  # What is Podman?
  If you are not already familiar with podman, let us give you some brief background.  Podman is an Open Container Initiative (OCI) compliant container runtime for Linux.  It is not the purpose of this lab to teach you the basics of Podman, but know that it is a docker-compatible command line tool that will allow you to run Containers on linux.  You can find more labs related to Podman in other [Red Hat Online Labs](https://lab.redhat.com) if you would like to learn more.

  # What is a Pod?
  Additionally you may be wondering what a Pod is within podman.  A pod quite simply is a container for containers.  A pod will group containers together, linking their dns resolution, networking, and a few other resources.  This also allows you to manage them as an individual unit.  If you had, for example, and web application, and the database back-end for that application all within a pod.  Those two containers would be able to communicate with each-other, and you would be able to start and stop both containers by telling the pod to start or stop once it is defined. 

  # And what then, is Quadlet?
  Quadlet is a generator for Systemd that will create unit files to control podman resources through systemctl.  For instance, you can define a pod within quadlet, and then use systemctl to start and stop the entire pod.  When these pods are then stopped, they are deleted, and then when they are started, they are re-created from the definition.  Turning container updates into a simple `systemctl stop <podname>` then `systemctl start <podname>`.

  In this lab we will use all of these technologies to show you how to more easily manage container's on your Red Hat Enterprise Linux system. 

  # Making our pod
  Let's start out by creating a pod, and some containers, using quadlet. 

  First, we will define our Pod, create a file inside of `/etc/containers/systemd` called `my-pod.pod` with `vim`

  ```bash,run
  vim /etc/containers/systemd/my-pod.pod
  ```
  And paste the following into the file

  ```bash,run
  [Unit]
  Description=A simple web application pod

  [Pod]
  PublishPort=8080:80
  ```
  This creates a pod definition that simply names the pod, and forwards port 8080 to port 80 inside of the pod.

  You can save, and exit `vim`.

  Now, let's make a container to run inside of our pod.

  ```bash,run
  vim /etc/containers/systemd/my-webapp.container
  ```

  And just like before, we'll paste this content into the file
  ```bash,run
  [Unit]
  Description=The main web server container

  [Container]
  Image=registry.access.redhat.com/ubi9/httpd-24
  Pod=my-app.pod
  ```
  Similar to our pod file, this creates a container definition from the RHEL Ubi based httpd-24 container image on Red Hat's public registry `registry.access.redhat.com`.

  And now, we will add a second container to our pod, to act as a database for the web application. 

  ```bash,run
  vim /etc/containers/systemd/my-database.container
  ```

  Now, paste the following into the file. 

  ```bash,run
  [Unit]
  Description=The supporting Database back-end

  [Container]
  Image=registry.access.redhat.com/rhel9/mariadb-1011
  Pod=my-app.pod
  Environment=MYSQL_ROOT_PASSWORD=r3dh@t123
  Environment=MYSQL_USER=dbuser
  Environment=MYSQL_PASSWORD=redhat
  Environment=MYSQL_DATABASE=testdb
  ```

  
