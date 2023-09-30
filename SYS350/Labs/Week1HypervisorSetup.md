# ESXi and Basic Networking

### Reflection

------

During this lab I accessed my supermicro using viewportal. I installed ESXi7 using virtual storage from the console redirection application. After installing ESXi I configured a static IP address from the console then accessed ESXi using the native browser ESXI client via super3.cyber.local. I also setup DataStores within ESXi and configured a vSwitch, Portgroup, and an Internal Network. Also setup pfSense and networked it and setup Mgmt.

There were no issues with accomplishing this milestone, however ironically the documentation took longer to make than the lab itself. 

### Console Redirection

------

Under the *Remote Control* tab click *Console Redirection* then click *Launch Console*. This will download the console to login to the server.

Download the Vmware VMvisor on the rackstation2.cyber.local SMB share. Then under *Virtual Media* click on *Virtual Storage* then a box will pop up for Virtual Storage settings. In the Virtual Storage box click *Open Image* and browse to the Vmware VMvisor iso image that was downloaded. After selecting the iso click *Plug in* and then press Ok.

![image-20220125013509178](https://github.com/liamb8/sys350/blob/main/Pictures/VirtualStorage.JPG)

Reboot the box, using the virtual keyboard and use F11 to go to the boot menu. Pick the UEFI Virtual CDROM and boot to the installer.

### VMWare Installer

------

![image-20220125013719159](https://github.com/liamb8/sys350/blob/main/Pictures/VmwareInstaller.JPG)

There shouldn't be any VMFS or claimed partitions, Install ESXi on the smaller of the two drives if there is a difference between them.

![image-20220125013906466](https://github.com/liamb8/sys350/blob/main/Pictures/DiskSelection.JPG)

 Choose all the defaults, make sure to use a strong root password when prompted. Then press F11 to install. 

**Unplug the Virtual Media when Complete**

![image-20220125014032552](https://github.com/liamb8/sys350/blob/main/Pictures/UnplugVirtualStorage.JPG)

Reboot the box

### Network Configuration

------

![image-20220125014633065](https://github.com/liamb8/sys350/blob/main/Pictures/ExsiNetwork.JPG)



### Configuring Datastores

------

Go to the *Storage tab* under the *Navigator* and click on *New Datastore*. Under select creation type select *create new VMFS datastore*. 

Call it datastore2-super3 and pick the device shown. Use VMFS6 and when complete it should look similar to this:

![image-20220125015102074](https://github.com/liamb8/sys350/blob/main/Pictures/DataStoreLists.jpg)

Click on *datastore browser* then select *datastore2-super3* and create a new directory called isos. Upload the pfSense and Xubuntu ISOs to the isos directory. 

![image-20220125015349880](https://github.com/liamb8/sys350/blob/main/Pictures/UploadIsos.JPG)

### 

### Configuring Vswitch, Portgroup, and Internal Network

------

Under the Navigator go to the *Networking tab*. Then go to *Virtual Switches* and select *add standard virtual switch*. Follow the config below to setup a virtual switch:

![image-20220125015642904](https://github.com/liamb8/sys350/blob/main/Pictures/NewVirtSwitch.jpg)

After configuring the virtual switch go to the *port groups* tab and select *add port group*. Follow the config below to setup a port group:

![image-20220125015835026](https://github.com/liamb8/sys350/blob/main/Pictures/NewPortGroup.jpg)

### Setup Pfsense

------

##### Create a new Pfsense VM

```
ESXi6.5 Compatability (You can export it later as an OVA if you want)
* Other FreeBSD (64-bit) 
* put this on datastore2 
* 2GiB RAM 
* THIN provision the disk
```

- 2 Network Cards 

- 1 on VM Network 

- 2 on 350-Internal (need to add the network card) 

- CD Points to pfSense ISO file 

- Install pfSense
  - Before reboot 
  - poweroff 
  - disconnect cd by changing to "Host Device" 
  - snapshot called Base 

### Configure the Firewall

------

Set Interface IP Addresses to the following 

- WAN/em0 
  - static ip of 192.168.3.41/24
  - gateway of 192.168.3.250 

- LAN/em1 
  - static ip of 10.0.17.2/24 
  - no on dhcp

### Configure MGMT

------

**Installation**  

5GiB ram, 2CPU, 30GiB Thin Disk

Put it on VMNetwork for Installation Minimal Installation (Option in xubuntu 20.10)

Make accounts generic (like champuser) as you will grab a snapshot for ova creation later

poweroff

remove cdrom 

snapshot as Base

 **Configuring** **Networking** 

- Put this on 350-Internal IP
  - Address of 10.0.17.100/24
  - Gateway is 10.0.17.2 
  - DNS is also 1.1.1.1 

### Finish Pfsense Config

------

Go through the wizard, changing the following values 

- Hostname: pf3

- Domain: liam.local
- Primary DNS Server: 1.1.1.1 
- Uncheck Unblock RFC1918 Private Networks Secure your admin password 
