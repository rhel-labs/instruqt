---
slug: bello
id: x1c1wtlvt8cu
type: challenge
title: Packaging bello - Getting and Positioning the Source
teaser: To start your RPM packaging journey, the first step is to obtain the source
  code and ensure it's positioned, named, and formatted correctly to use when building
  an RPM.
tabs:
- id: fhdbnhe9lcin
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Over the next few steps, you will be taking a bash program, `bello` and packaging it into an RPM package.

First, you will take the source code for `bello` and put it in the right location in your RPM buildroot directory structure, created in the previous step.

# Obtaining the source files

Your work from the previous challenge has been preserved,
but each challenge starts over as the **root** user.
Switch to the **rhel** user again.

```
sudo -iu rhel
```

Navigate to the **rpmbuild** directory.

```
cd rpmbuild
```

The source code archive for **bello** is located at **~/downloads/bello-0.1.tar.gz** on your system.
Move the source code archive into the **SOURCES** directory.

```
mv -v ~/downloads/bello-0.1.tar.gz SOURCES/
```
```txt,nocopy
renamed '/home/rhel/downloads/bello-0.1.tar.gz' -> 'SOURCES/bello-0.1.tar.gz'
```

Verify the source code archive is in the correct location.
The filename will be displayed in red text to indicate that it is a compressed file.

```
ls SOURCES/bello*
```
```txt,nocopy
SOURCES/bello-0.1.tar.gz
```

In the next step, you will work on writing the SPEC file contents.