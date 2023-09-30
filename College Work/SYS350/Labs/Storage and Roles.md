# Storage and Roles

## Reflection

During this lab I mounted the SMB share on the mgmt box. I also added a new NFS Share in vcenter named `snyology-super3`. After adding the NFS Share I uploaded a xubuntu template to the `snyology-super3` datastore. After this I created a new folder called `rbac` and creating four new folder names under it called `alice`, `bob`, `charlie`, and`shared-vms`. After this I created three new AD-Users called `alice`, `bob`, `charlie` and two new groups to AD called `sys350-power-user` and `sys350-restricted-user`. I then setup permissions for them to connect to vcenter and allowed them to only do specific actions. 



# Add NFS Share

In vcenter on the page which lists all the vms right click on sys350 and select `Storage` then `New Datastore`.  Set the Type to `NFS` and use `NFS 3` as the version. Follow the screenshot below for the `Name and Configuration` section.

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab4/NFSDatastore.JPG)

After this click `Next` and in the `Host Accessibility` section select `super3.liam.local` then click `Next` and complete the setup. 

Next right click on sys350 again in the vm list and select `Deploy OVF Template`. For the URL use the direct URL the ova is stored at or select the local file stored on the VM. Go through the steps until the `Select Storage` part and choose `synology-super3` and use `Thin Provision` as the disk format. 

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab4/OVFTemplate.JPG)

Use this for the network:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab4/Network.JPG)

After this wait until the template has been added. Next right click on sys350 again and select `New Folder` then `New VM and Template Folder`. Call this folder `rbac` and then under the `rbac` folder create 4 new folders called `alice`, `bob`, `charlie`, and`shared-vms`. After adding these new folders create 3 new AD-Users called `alice`, `bob`, `charlie`. Then create 2 new AD Groups called `sys350-power-user` and `sys350-restricted-user`.  Add `alice` to `sys350-power-user` then `bob` and `charlie` to `sys350-restricted-user`. 



Adjust the permissions on the `alice` folder so they look like this:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab4/FolderPermission.JPG)

Move a VM into the `alice` folder and login as `alice` into vcenter and the vm in that folder should show up now. 

Move a different vm into the `shared-vms` folder and assign the permissions of `sys350-power-user` to `virtual machine power user` and `sys350-restricted-user` to `virtual machine console user`. Alice should now have power level privileges over VMs in the `shared-vms` folder. While Bob and Charlie should be limited to a handful of console operations.

After this go to the three bar tab on the top left of vcener and select `Administration`. Under `Access Control` select `Roles` then find the `Virtual Machine console user role` and clone it and call it `Virtual Machine console no power user` then restrict the role from being able to `Power On` and `Power Off` vms. Then change the permissions for the `shared-vms` folder so that the restricted user group now gets the new limited role. 



