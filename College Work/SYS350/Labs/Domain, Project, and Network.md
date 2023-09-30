# Domain, Project, and Network

## Reflection

While setting this up I think that it was good experience learning how to setup a network using OpenStack. Although I felt that it's still greatly lacking compared to VCenter. It's definitely not as easy to setup as it would be using VCenter. Although OpenStack is free in my opinion it's far from being a competitor with VCenter. Maybe in the future when more development is done it could become a possible competitor until then I think that it has a long way to go.  

## Enabling IP Forwarding

Enable ip forwarding on ubuntu using sysctl

```
sysctl -w net.ipv4.ip_forward=1
```

Also, uncomment the line in `/etc/sysctl.conf` that says `#sysctl -w net.ipv4.ip_forward=1` so that any changes stay after a reboot.  

## Create New Domain with Admin User

Create a new domain called "liam" using the following command:

```
openstack --insecure domain create --description "Liam's Domain" liam
```

If there are any authentication errors download the `admin-rc.sh` and run `source ~/Downloads/admin-openrc.sh` and put in your admin credentials.



Create an admin user for the domain:

```
openstack --insecure user create --domain liam --password <password> <admin user>
openstack --insecure role add --domain liam --user-domain liam --user <admin user> admin
```



Enable multi tenancy so you can log into the newly created domain.

```
sudo bash -c 'cat > /var/snap/microstack/common/etc/horizon/local_settings.d/_10_enable_multidomain_support.py' << EOF

OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True

EOF

sudo snap restart microstack.horizon-uwsgi
```

After microstack restarts you should be able to login to the domain created earlier. Next create a project called "SYS350".

`openstack --insecure project create --domain liam SYS350`

Give the domain admin account permissions to the project.

```
openstack --insecure role add --project SYS350 --project-domain liam --user lbarry-adm --user-domain liam member
openstack --insecure role add --project SYS350 --project-domain liam --user lbarry-adm --user-domain liam admin
```



## SSH Keypair

When logging into the domain the "SYS350" project should now show up. 

Create a keypair using the following command:

`openstack --insecure keypair create --private-key ~/Downloads/sys350.pem --type ssh sys350`



## Network

Create a new network called `sys350` on openstack.

`openstack --insecure network create sys350`

Now assign a subnet to the network using the following command:

`openstack --insecure subnet create --network sys350 --subnet-range 172.16.99.0/24 --allocation-pool start=172.16.99.101,end=172.16.99.200 --dns-nameserver 8.8.8.8 sys350subnet`

To get outbound traffic setup a router:

```
openstack --insecure router create sys350router
openstack --insecure router set --external-gateway external sys350router
openstack --insecure router add subnet sys350router sys350subnet
openstack --insecure floating ip create external
```



## Security Groups

Setup security groups to allow SSH, ICMP, and RDP. 

```
openstack --insecure security group create sys350secgroup
openstack --insecure security group rule create --remote-ip 0.0.0.0/0 --dst-port 22:22 --protocol tcp --ingress sys350secgroup
openstack --insecure security group rule create --remote-ip 0.0.0.0/0 --dst-port 3389:3389 --protocol tcp --ingress sys350secgroup
openstack --insecure security group rule create --remote-ip 0.0.0.0/0 --protocol icmp --ingress sys350secgroup
```



## Create an Instance

Create a cirros instance using the following command:

`openstack --insecure server create --flavor m1.small --image cirros --network sys350 --key-name sys350 sys350-cirros`

You can assign a floating IP in the OpenStack dashboard.

Attach a security groups to the newly created instance.

`openstack --insecure server add security group sys350-cirros sys350secgroup`

Connect to the instance by using ssh:

`ssh cirros@10.20.20.169 -i ~/Downloads/sys350.pem`

Do the same thing for the bullseye image. Then run the following command to upload the iamge to the "SYS350" project.

`openstack --insecure image create --disk-format qcow2 --min-disk 8 --min-ram 512 --file ~/Downloads/debian-11-generic-amd64.qcow2 --public bullseye`

After this run the same commands used for the cirros image.

```
openstack --insecure server create --flavor m1.small --image bullseye --network sys350 --key-name sys350 bullseye
openstack --insecure server add floating ip bullseye Floating-IP-Address
openstack --insecure server add security group bullseye sys350secgroup
```

You can now ssh into the instance using:

`ssh debian@10.20.20.169 -i ~/Downloads/sys350.pem`

Remove the known hosts file in the .ssh directory if you get an error.