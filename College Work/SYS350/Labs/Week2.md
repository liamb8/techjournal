# Milestone 2 - AD, vCenter, and SSO Integration



# Reflection

I wouldn't say that this lab was easy nor hard. It was very time consuming with a lot of the updates and installing things. I ran into some issues with the `pool.ntp.org` not working. It ended up being that I couldn't connect to it since I didn't have any internet. The internet wasn't working because I had set the default gateway ip address incorrectly on the pfsense firewall. After fixing the ip address on the pfsense GUI it didn't properly set the new ip address as the default gateway. The setting was at automatic and so I had to change it to the default gateway that I want to use in order to get it to work.

## Add Server 19 and VCSA ISOs to DataStore 2

Download VCenter and Window Server ISOs from the link provided. Fastest way is to cd into the directory then use `wget` to download them there.

`wget http://192.168.3.110/FileDownload`

![DataStoreAdd](https://github.com/liamb8/sys350/blob/main/Pictures/Lab2/DataStoreAdd.JPG)

## Setup Active Directory

Keep the VM on the VMNetwork interface to get a DHCP IP from Foster. Fully update the system by going into the settings and checking for updates until there aren't any updates left. Set updates to manual once done. Set the time zone to EST and install VMWare Tools. 

Install SSH and Sysprep the System by using this script (save as a ps1 file):

```
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
# a good time to complete via remote ssh
Set-Service -Name sshd -StartupType 'Automatic'
Set-ItemProperty "HKLM:\Software\Microsoft\Powershell\1\ShellIds" -Name ConsolePrompting -Value $true
New-ItemProperty -Path HKLM:\SOFTWARE\OpenSSH -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
Write-Host "Create a deployer user: Enter Password"
$pw = Read-Host -AsSecureString
New-LocalUser -Name deployer -Password $pw -AccountNeverExpires
Add-LocalGroupMember -Group Administrators -Member deployer
Write-Host "Pull down unattend.xml and then sysprep the box"
wget https://raw.githubusercontent.com/gmcyber/480share/master/unattend.xml -Outfile C:\Unattend.xml
C:\Windows\System32\Sysprep\sysprep.exe /oobe /generalize /unattend:C:\unattend.xml
```

Sysprep might fail to fix this reboot the box and run the last line of the script. Once done poweroff the VM and change the network to 350-internal and change the CDROM to Host Device. After this take a snapshot of the VM and call it base. 

## Install ADDS/DNS onto the Windows Server 

Go to Server Manager and click Manage then click Add Roles and Features. Keep clicking Next until you reach the Server Roles page and check off in the Roles list **Active Directory Domain Services** and **DNS**. After this click Next until you reach the Confirmation page and wait until it confirms all the pre-requisites are met and then click **Install**.

Once installed click on the Flag in the Server Manager to promote your Domain and click on Add a new forest under deployment options. Enter in **liam.local** as the root domain name and then click next to set a DSRM password and continue clicking next until you finish. 

Add a Named User called **lbarry-adm** and add it as a member of **Domain Admins** and E**nterprise Admins** Add A Records and PTR records for: 

- fw01 
  - 10.0.17.2 
- mgmt1
  - 10.0.17.100 
- Make sure AD350 gets a PTR record

## Install vCenter

Mount the vCenter ISO to Mgmt1 it will automatically mount once you connect it. Once connected do `cd /media/liam/VMware VCSA/vcsa-ui-installer/lin64` once in this directory type in `./installer` and press enter. This will start the vCenter installer.

Once the installer shows up press **Install** and under the ESXi host type in `super3.liam.local` and then type in the **User:** root and the password for the EXSi host. After this press next and click Yes on the Certificate warning. In the Set up  vCenter Server VM under VM name type `venter` and set a root password. As the deployment size select Small and leave the storage size as default. Make sure to select datastore2-super3 as the datastore. Under the network settings configure it as a static ip address. Then press next then press Finish and wait until Stage 1 is done. 

In Stage 2 under the Time schyronization mode put `pool.ntp.org`. Under the SSO Config create a new SSO domain as `vsphere.local` and create a secure password. Click next until you reach the review page and click Finish. Once Stage 2 is done vCenter will be setup.

To get to the Server Management site use `vcenter.liam.local:5480`. Make sure to check for updates and select 7.0.3.00100. Go through the steps to complete the update and wait for it to finish installing. 

Add a Datacenter by right clicking on `vcenter.liam.local` and name it sys350 and then add a host by right clicking using the host ip address of `super3.liam.local`. Under connection settings enter the username of root and the password. Keep clicking next until you reach the review page and click finish.



## SSO Integration

In the vSphere Client click the 3 lines on the top left and select Administration. Then select Configuration under Single Sign On and then Active Directory Domain. Then click Join Add and add in the domain information with the username and password for the account on the domain. 

Reboot vCenter after this. 

Under the same configuration section click on Identity Sources and then click Add. Leave everything as is and then click Add and then set it as default. 

Under the Single Sign On section select Users and Groups and click on Add Members. Then under Add Members select liam.local and then in the search bar select Domain Admins. 

