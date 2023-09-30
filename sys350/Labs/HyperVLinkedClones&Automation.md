# Milestone 12 - HyperV - Linked Clones and Automation 1



## Reflection

During this lab we setup a new base image for Ubuntu and a child image of Windows 10. We also made linked clones of both of them using the Hypver-V Manager. While doing the milestone I felt that in comparison to setting up linked clones in vCenter it may have not been as straight forward when using the Hyper-V Manager. I think that vCenter's process of creating a clone was easier to understand. In regards to using Powershell vs Pyvmomi it was like day and night. Using powershell was far easier than the more complex option of using pyvmomi with vCenter. 



## Setting up Ubuntu Image

First download the Ubuntu Desktop image iso and sysprep it using this [script](https://github.com/gmcyber/480share/blob/master/hyperv-ubuntu-sealer.sh). Create the VM the same way as before using WAC in the Virtual Machines extension select Add -> New. Make sure the VM has 2 processors and at least 2GB of RAM and is on the Hyper-V-WAN network. After creating the VM start it up and follow the Ubuntu Desktop install directions. After it's done installing use the sysprep script to sysprep the vm. After this go back to WAC and shutdown the Ubuntu VM and go to Manage -> New Checkpoint. This is similar to a snapshot where you can revert to an earlier image of the vm if needed. 



After this go to the File Explorer where the Ubuntu Desktop vhdx file is located and open the properties and set it to `Read-only`. 

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab12/UbuntuReadOnly.jpg)

After making it Read-only create a new Child Disk. Go to the Hyper-V Manager and select Action then New -> Hard Disk, Next -> VHDX, Next -> Differencing, Next -> VM Name, Next -> Create a new folder for the linked clone to be stored in, Next -> Select location of the parent VM vhdx file. Select Next then read teh summary and select finish.

Create a new VM in the Hyper-V Manager set everything up as usual adding the VM Name, Generation, Assigned Memory, Network, and Hard Disk. When you get to the `Connect Virtual Hard Disk` step select `Use an existing virtual hard disk` and choose the location of the newly created child disk vhdx file. Once finished setting up the VM you can then power it on and use it like the original parent VM.



## PowerShell Commands for Hyper-V

 

**Stopping a VM**

```
Stop-VM -Name <VM name>
```

**Creating New Checkpoint**

```
Get-VM -Name <VM Name> | Checkpoint-VM -SnapshotName <snapshot name>
```

**Starting a VM**

```
Start-VM -Name <VM name>
```

**Changing VM's Network Adapter**

```
Connect-VMNetworkAdapter -VMName <VM name> -SwitchName <virtual switch network name>
```

**Creating a Child Disk**

```
New-VHD -ParentPath <parent .vhdx file path> -Path <child .vhdx file path>
```

**Creating a Linked Clone**

```
New-VM -VHDPath <child .vhdx file path> -Name <VM name> -MemoryStartupBytes <memory (2048MB)> -Generation <generation number> -SwitchName <virtual switch network name>
```