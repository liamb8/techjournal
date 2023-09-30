# OpenStack and Windows



## Reflection

While doing this lab at first it took awhile since I was trying to use PowerISO but it never ended up working. I ended up switching to just adding a second CD ROM to connect the VirtIO drivers to the instance. This process was also different compared to using VCenter as I felt that it's more inconvenient and not the fastest way to do it. In addition the process of setting everything up felt more complicated compared to doing this on VCenter. Although OpenStack is free to use it still lacks in many ways compared to VCenter. Hopefully the development of OpenStack gets better in the future and we'll see more features that could be comparable with VCenter. 

## Setting up Windows Server Image

Install the Virtual Machine Manager using commands below:

```
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
sudo systemctl is-active libvirtd
```



Download a Windows Server 2019 iso, and VirtIO Drivers. Follow the guide [here](https://yooniks9.medium.com/openstack-create-windows-server-2016-2019-image-vmdk-part-ii-d4f24c880632) on how to setup the image. After going through the steps on setting up the image when logged into the Windows Server use `sconfig` to change the time zone to EST and set updates to manual. Also enable RDP, and allow it through the firewall. Install the virtio-win drivers then install google chrome and lastly install CloudBase Init. Once this is done you can import the Windows image into OpenStack.



##  Import Windows Image

Upload the Windows Server 2019 image to the SYS350 project in OpenStack.

```
sudo cp /var/lib/libvirt/images/win2019.img ~/Desktop/
sudo chown lbarry:lbarry ~/Desktop/win2019.img 
source ~/Downloads/SYS350-openrc.sh
openstack --insecure image create --disk-format raw --min-disk 0 --min-ram 0 --file ~/Desktop/win2019.img --public server19
```

After this create a Windows Server instance using the image created. You will need to create a new flavor since the default flavors don't have enough storage space. Create a new one with the same details at m1.medium except put the storage space as 30GB. Make note of the floating ip created to use in the last step.

```
openstack --insecure flavor create --ram 4096 --disk 30 --vcpus 2 m1.med
openstack --insecure server create --flavor m1.med --image server2019 --network sys350 --key-name sys350 server19-instance
openstack --insecure server add security group server19-instance sys350securitygroup
openstack --insecure floating ip create external
openstack --insecure server add floating ip server19-instance <floating-ip>
```

After doing this decrypt the admin password using the `sys350.pem` key using the following command:

`nova --insecure get-password "server19-instance" 2>/dev/null | base64 -d | openssl rsautl -decrypt -inkey ./sys350.pem`

After getting the admin password install Remmina for RDP using the commands below:

```
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
```

Open Remmina and type in the floating ip that's assigned to the instance for the Windows Server. After you're connected type in `Admin` for the username and the password that was decrypted.