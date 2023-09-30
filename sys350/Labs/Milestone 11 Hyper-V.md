# Milestone 11 Hyper-V



## Reflection

In this lab I felt that it was a lot easier to do than using OpenStack. It was far less complicated and a more workable GUI than OpenStack was. I did run into some issues when setting it up though as I was left wondering why my `Hyper-V-WAN` wasn't connecting to the internet only to find out that it wasn't set on the right interface. After fixing that everything started to work pretty much. When networking the Windows 11 VM the internet worked at one point then after I restarted the VM it broke for some reason. I reinstalled a new one and it ended up working again. The main issue which I still don't know why it's happening is that if I try to connect to `super3:6516` outside of my VM it doesn't work. I can reach the ip address without any issues but cannot connect to it in the browser. I set the proper firewall rules for it but didn't work still. 

## Install HyperV and Management Tools

Change hostname to `super3`

Open Windows Server Manager and click on `Add Roles and Features`

Install Hyper-V `Server Roles -> Hyper-V` and then install that role. 

[](https://github.com/liamb8/sys350/blob/main/Pictures/Lab11/Hyper-V.png)

## Configure Hyper-V Network

After installing the Hyper-V role open the Hyper-V Manager.

After launching the Hyper-V Manager under `Action` click `Virtual Switch Manager`. Add an `Internal` and `External` network. Make sure the external network is on the correct interface otherwise you won't get any internet since it doesn't know where to send traffic to. 

[](https://github.com/liamb8/sys350/blob/main/Pictures/Lab11/VirtualSwitch.png)

## Install Windows Admin Center

The installation steps for Windows Admin Center are [here](https://github.com/liamb8/sec440/blob/main/VM%20Config/WAC%20Lab/Windows%20Admin%20Center.md). I found that for whatever reason WAC sometimes doesn't start when trying to use PowerShell. So you may need to go into `Task Manager` and find the process for WAC and start it manually.

## Configure Pfsense and Windows 11

Download pfsense [here](http://192.168.3.110/iso/pfSense-CE-2.5.2-RELEASE-amd64.iso).

Create a new virtual machine using `Windows Admin Center`. Go to WAC and mage `super3` then go to the `Virtual Machines Extension`. From there select `Add` and use the following settings:

```
Name: pf3
Generation: Generation 1
Path: D:\Hyper-V (Hyper-V Host Setting)
Virtual Processors: 1
Startup Memory: 2GB
Virtual Switch: Hyper-V-WAN
Isolation Mode: None
Storage: New Disk 20 GB
Operating System:
Install an OS from an image file (.iso)
Browse to iso path
```

After this select `Create`, before starting the VM go to `Settings`. Change the boot order so that `CD` is first and make sure secure boot is off. After this add a new virtual network adapter for `LAN-Internal`.

When setting up pfsense use `192.168.3.43/24` as the WAN ip and `10.0.5.2/24` as the LAN ip.

After setting up pfsense import the Windows 11 VM meant for the Hypervisor. Go back to the `Virtual Machine Extension` and select `Import` instead of `New`. Then browse to the folder where you downloaded the Windows 11 image and select it. After this for the `VM` select `WinDev2202Eval` and check off `Create a unique ID for the VM`. The `New Location` setting should be under `D:\Hyper-V (Hyper-V Host Setting)`. 

After some time the vm should show up under the list of vms. Make sure to edit it before starting and give it `4GB` of RAM and add it to the `LAN-Internal` network. Power it on and open the console where you should be automatically logged in as `User`. After setting the ip address for the Windows 11 VM you should be able to connect to the internet. 