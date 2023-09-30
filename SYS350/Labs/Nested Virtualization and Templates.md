# Nested Virtualization and Templates



## Reflection

During this lab I added new PTR records for nested1-3 with their associated ip addresses. I also created templates to setup Ubuntu and CentOS Vms. Overall the lab wasn't that bad the only issue was with the nested VMs. For some reason after setting them up they wouldn't save the network configuration done in the Deploy OVA Template setup. It also didn't accept the password setup in that process either. 

## Add Nested PTR Records to DNS

In the Server Manager go to *Tools* then *DNS*. After this the DNS Manager will pop up go to the Forward Lookup Zones and right click liam.local and create a New Host (A Record). Input the name and then input the ip address and click add host.

![image-20220207222744513](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/DNS.JPG)



## Download Nested VM

Go to 192.168.3.110/ova and download the Nested_ESXi ova file. After this in Vcenter deploy the OVF file following the steps below. Go through steps 1-9 and leave everything except step 1, 6, and 7 as default settings. Repeat these steps 2 more times for nested2 and nested3 while changing the ip addresses accordingly for both. After adding nested1-3 add them as hosts under sys350 in vcenter.

![image-20220207223823146](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/OVFTemplateURL.JPG)

![image-20220207223858700](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/OVFTemplateStorage.JPG)

![image-20220207224443564](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/OVFTemplateDone.JPG)

## Change VSwitch Settings

![image-20220207225043373](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/VSwitchSettings.JPG)

## Convert To Template

Download the ubuntu-20.0.4.3 ova from 192.168.3.110 and upload it to the isos directory in ESXi. Configure the VM like below:

- 350-Internal
- Stick with defaults
- VM Should get a DHCP IP Address
- Add a deployer user and password
- install open-vm-tools
- install perl if it's not already intalled
- Powerdown
- Remove the CD, point it to client device
- Take a snapshot called Base

Go to the shorcut menu and select VM Customization Specifications Shortcut. Create a shortcut with the specifications listed in the picture below:

![image-20220207225604806](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/UbuntuShortcutConfig.JPG)

After this create a new VM from the Template make sure to select Customize the operating system in order to use the template.

![image-20220207225748546](https://github.com/liamb8/sys350/blob/main/Pictures/Lab3/CustomOperatingSys.JPG)

Follow these same steps when setting up a vm with CentOS. 
