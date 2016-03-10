# devbox - start developing anywhere, fast

I have developed software on Windows, OS X and Linux machines. Tools like Vagrant and Docker have been created to be able to start developing software as fast as possible, in any environment. However, you still need to set up your _development machine_ first, because you need your tools like Git, cURL or Vim.

In order to minimize the amount of work needed to convert a given computer to a customized _development machine_, I have created this project. It is not designed to be helpful for everyone, but it certainly helps me.

## What's the idea?

The physical host you're working at should only have a minimal amount of tools installed. Installing all kinds of programming languages, tools and libraries will only clutter the host. Most of the things should run in a virtual machine that's easy to recreate when you made too much of a mess.

Therefore, I suggest that the host is running only the following:

* Your IDE of choice, in my case [IntelliJ IDEA](https://www.jetbrains.com/idea/download/).
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
* An SSH client to connect into the VM. [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html), for example, or the SSH Remote Run plugin in IDEA.

Additionally, we're gonna use CoreOS in the VM. This gives us a very basic Linux machine without any package manager whatsoever (the OS will update by simply replacing its entire read-only filesystem with a new image from time to time), but great support for [Docker](https://www.docker.com/). Which means, we can build and run our software in extremely portable containers.

## Initial Setup

Download the [most recent CoreOS ISO](http://stable.release.core-os.net/amd64-usr/current/coreos_production_iso_image.iso). Create a VirtualBox machine with a decent amount of RAM and hard disk space. Make sure it has two network interfaces configured: A NAT one and a host-only one. Set the machine's boot order to prefer hard disk, then optical. Insert the ISO in its optical drive and boot the thing.

Next, download [my installation script](https://raw.githubusercontent.com/scy/devbox/master/coreos/install.sh) (`curl -LO` might come in handy) and run it. It will ask you for a hard disk to install to, set up CoreOS there, and reboot.

That's it. CoreOS boots up and shows a login prompt as well as its IP addresses and SSH keys. You can log in as `core` using the password specified in `cloud-config.yml`. The same credentials also work for SSH connections (use the host-only network for that).

Note that CoreOS doesn't support VirtualBox shared folders. You'll have to copy files to and from the VM using SSH (SCP, SFTP, rsync). But what it does have is SSH, Vim, cURL and Git.
