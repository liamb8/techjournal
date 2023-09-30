# OpenStack Tutorials



## Install OpenStack

```nohighlight
$ sudo snap install microstack --beta --devmode
```

```nohighlight
$ sudo microstack init --auto --control
```

In order to launch an instance of OpenStack use the following command:

```nohighlight
$ microstack launch cirros --name test
```

Access OpenStack with ssh using:

```
`ssh -i /home/lbarry/snap/microstack/common/.ssh/id_microstack cirros@10.20.20.96`
```



## Components

```nohighlight
$ microstack.openstack server list --all-projects
```

This returns the instance launched during the Install steps. 

```nohighlight
$ sudo snap get microstack config.credentials.mysql-root-password
```

Connect to the MySQL using the obtained password:

```nohighlight
$ sudo microstack.mysql -u root -p
```

To list all queues run:

```nohighlight
$ sudo microstack.rabbitmqctl list_queues
```

In order to login to the OpenStack dsahboard obtain the admin user password:

```nohighlight
$ sudo snap get microstack config.credentials.keystone-password
```

Then, visit `https://10.20.20.1`, type the obtained credentials, and click the **Sign in** button.

To remove the alias from before use:

```nohighlight
$ sudo snap unalias openstack
```

Download the RC file in the OpenStack dashboard then use this command to communicate with the OpenStack cloud:

```nohighlight
$ source ~/Downloads/admin-openrc.sh
```

You can test this by using:

```nohighlight
$ openstack --insecure server list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/ServerList.JPG)

## Services

To list all registered OpenStack services, execute the following command:

```nohighlight
$ openstack --insecure catalog list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/CatalogList.JPG)

To communicate with Keystone, you can use the OpenStack client. For example, to list all users created by Keystone, execute the following command:

```nohighlight
$ openstack --insecure user list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/UserList.JPG)

To communicate with Glance, you can use the OpenStack client. For example, to list all images uploaded to Glance, execute the following command:

```nohighlight
$ openstack --insecure image list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/ImageList.JPG)

To communicate with Neutron, you can use the OpenStack client. For example, to list all virtual networks created by Neutron, execute the following command:

```nohighlight
$ openstack --insecure network list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/NetworkList.JPG)

To communicate with Nova, you can use the OpenStack client. For example, to list all hypervisors managed by Nova, execute the following command:

```nohighlight
$ openstack --insecure hypervisor list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/HypervisorList.JPG)

To communicate with Cinder, you can use the OpenStack client. For example, to list all volumes created by Cinder, execute the following command:

```nohighlight
$ openstack --insecure volume list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/VolumeList.JPG)

## Dashboard

To list all running instances inside of the *admin* project, navigate to **Project** -> **Compute** -> **Instances**:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/DashInstances.png)

To list all hypervisors, navigate to **Admin** -> **Compute** -> **Hypervisors**:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/DashHypervisors.png)

To list all user accounts, navigate to **Identity** -> **Users**:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/DashUsers.png)

## Templates

Download Ubuntu 20.04 LTS and Ubuntu 18.04 LTS images to the workstation.

To upload the Ubuntu 20.04 LTS image to Glance, execute the following command:

```nohighlight
$ openstack --insecure image create --disk-format qcow2 --min-disk 8 --min-ram 512 --file Downloads/focal-server-cloudimg-amd64-disk-kvm.img --public 20.04
```



To upload the Ubuntu 18.04 LTS image to Glance, execute the following command:

```nohighlight
$ openstack --insecure image create --disk-format qcow2 --min-disk 8 --min-ram 512 --file ~/Downloads/bionic-server-cloudimg-amd64.img --private 18.04
```

To list all images, execute the following command:

```nohighlight
$ openstack --insecure image list
```

Flavors are other templates for creating instances on OpenStack. They define the size of virtual resources attached to the instance by default during the provisioning process.

To create the flavor, execute the following command:

```nohighlight
$ openstack --insecure flavor create --ram 1024 --disk 10 --vcpus 1 myfla
```

To list all flavors, execute the following command:

```nohighlight
$ openstack --insecure flavor list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/FlavorList.JPG)

## Identities

To create a new domain called *mydomain*, execute the following command:

```nohighlight
$ openstack --insecure domain create --description "My domain" mydomain
```

To list all domains, execute the following command:

```nohighlight
$ openstack --insecure domain list
```

Create an admin user to manage the identities through the OpenStack dashboard:

```nohighlight
$ openstack --insecure user create --domain mydomain --password admin admin

$ openstack --insecure role add --domain mydomain --user-domain mydomain --user admin admin
```

Enable Multi-domain support:

```nohighlight
$ sudo bash -c 'cat > /var/snap/microstack/common/etc/horizon/local_settings.d/_10_enable_multidomain_support.py' << EOF

OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True

EOF

$ sudo snap restart microstack.horizon-uwsgi
```

To create the **member** role, execute the following command:

```nohighlight
$ openstack --insecure role create _member_
```

To list all roles, execute the following command:

```nohighlight
$ openstack --insecure role list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/RoleList.JPG)

To create a project, execute the following command:

```nohighlight
$ openstack --insecure project create --domain mydomain myproject
```

To list all projects, execute the following command:

```nohighlight
$ openstack --insecure project list --domain mydomain
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/ProjectList.JPG)

To create the user, execute the following command:

```nohighlight
$ openstack --insecure user create --domain mydomain --password mypassword myuser
```

To list all users, execute the following command:

```nohighlight
$ openstack --insecure user list --domain mydomain
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/UserList.JPG)

To create a group, execute the following command:

```nohighlight
$ openstack --insecure group create --domain mydomain mygroup
```

To list all groups, execute the following command:

```nohighlight
$ openstack --insecure group list --domain mydomain
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/GroupListDomain.JPG)

To add the *myuser* user to the *mygroup* group, execute the following command:

```nohighlight
$ openstack --insecure group add user --group-domain mydomain --user-domain mydomain mygroup myuser
```

To assign the *member* role to the *mygroup* group on the *myproject* project, execute the following command:

```nohighlight
$ openstack --insecure role add --project myproject --project-domain mydomain --group mygroup member
```



To assign roles, execute the following commands:

```nohighlight
$ openstack --insecure role add --project myproject --project-domain mydomain --user admin --user-domain mydomain member

$ openstack --insecure role add --project myproject --project-domain mydomain --user admin --user-domain mydomain admin
```



## Multi-tenancy

download the RC file for the *myuser* user, visit the OpenStack dashboard at `https://10.20.20.1` and log in using the following credentials:

- **Domain** - Type `mydomain`
- **User Name** - Type `myuser`
- **Password** - Type `mypassword`

From the OpenStack dashboard landing page, navigate to the *myuser* drop-down menu on the top right, click it, and select **OpenStack RC File** to download the RC file:

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/RCFileDownload.png)

To set up the OpenStack client for the *myuser* user, open a new terminal window, execute the following command, and type *mypassword* when asked for the password:

```nohighlight
$ source ~/Downloads/myproject-openrc.sh
```

Create a key pair, execute the following command:

```nohighlight
$ openstack --insecure keypair create --private-key Downloads/mykeypair.pem --type ssh mykeypair
```

To list all key pairs, execute the following command:

```nohighlight
$ openstack --insecure keypair list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/KeypairList.JPG)

## Network

Log in as the *myuser* user through the OpenStack client, open a new terminal window, execute the following command, and type *mypassword* when asked for the password:

```nohighlight
$ source ~/Downloads/myproject-openrc.sh
```

To log in as the *myuser* user through the OpenStack dashboard, visit `https://10.20.20.1` and use the following credentials:

- **Domain** - Type `mydomain`
- **User Name** - Type `myuser`
- **Password** - Type `mypassword`

To create a the network, execute the following command:

```nohighlight
$ openstack --insecure network create mynetwork
```

To list all networks, execute the following command:

```nohighlight
$ openstack --insecure network list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/NetworkListDomain.JPG)

To create the subnet, execute the following command:

```nohighlight
$ openstack --insecure subnet create --network mynetwork --subnet-range 192.168.0.0/24 --allocation-pool start=192.168.0.101,end=192.168.0.200 --dns-nameserver 8.8.8.8 mysubnet
```

To list all subnets, execute the following command:

```nohighlight
$ openstack --insecure subnet list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/SubnetList.JPG)

To create a router, execute the following command:

```nohighlight
$ openstack --insecure router create myrouter
```

To list all routers, execute the following command:

```nohighlight
$ openstack --insecure router list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/RouterList.JPG)

To set the *external* network as a gateway for the router, execute the following command:

```nohighlight
$ openstack --insecure router set --external-gateway external myrouter
```

To attach the router to the *mysubnet* subnet, execute the following command:

```nohighlight
$ openstack --insecure router add subnet myrouter mysubnet
```

To allocate floating IP, execute the following command:

```nohighlight
$ openstack --insecure floating ip create external
```

To list all floating IPs, execute the following command:

```nohighlight
$ openstack --insecure floating ip list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/FloatingIPList.JPG)

To create a security group, execute the following command:

```nohighlight
$ openstack --insecure security group create mysecuritygroup
```

To list all security groups, execute the following command:

```nohighlight
$ openstack --insecure security group list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/SecurityGroupList.JPG)



To add the rule to the security group, execute the following command:

```nohighlight
$ openstack --insecure security group rule create --remote-ip 0.0.0.0/0 --dst-port 22:22 --protocol tcp --ingress mysecuritygroup
```

To list all rules in the security group, execute the following command:

```nohighlight
$ openstack --insecure security group rule list mysecuritygroup
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/SecurityGroupRuleList.JPG)

## Instances

Log in as the *myuser* user through the OpenStack client, open a new terminal window, execute the following command and type *mypassword* when asked for the password:

```nohighlight
$ source ~/Downloads/myproject-openrc.sh
```

To log in as the *myuser* user through the OpenStack dashboard, visit `https://10.20.20.1` and use the following credentials:

- **Domain** - Type `mydomain`
- **User Name** - Type `myuser`
- **Password** - Type `mypassword`

To launch instances, execute the following command:

```nohighlight
$ openstack --insecure server create --flavor myflavor --image 20.04 --network mynetwork --key-name mykeypair --min 2 --max 2 myinstance
```

Launching instances takes a while. You are going to see that instances go through the *BUILD* status first.

To list all instances, execute the following command:

```nohighlight
$ openstack --insecure server list
```

![](https://github.com/liamb8/sys350/blob/main/Pictures/Lab5/ServerList.JPG)

To associate floating IP, execute the following commands:

```nohighlight
$ IP=$(openstack --insecure floating ip list | tail -n 2 | head -n 1 | awk '{print $4}')

$ openstack --insecure server add floating ip myinstance-1 $IP
```

Set the right permissions for the key pair using:

```nohighlight
$ chmod 0400 Downloads/mykeypair.pem
```

To attempt to SSH to the instance, execute the following commands:

```nohighlight
$ IP=$(openstack --insecure floating ip list | tail -n 2 | head -n 1 | awk '{print $4}')

$ ssh -i ~/Downloads/mykeypair.pem -o StrictHostKeyChecking=no ubuntu@$IP
```

Attach a security group, execute the following command:

```nohighlight
$ openstack --insecure server add security group myinstance-1 mysecuritygroup
```

To delete an instance, execute the following command:

```nohighlight
$ openstack --insecure server delete myinstance-2
```



## Teardown

```
sudo snap stop microstack
sudo snap remove --purge microstack
sudo snap remove --purge openstackclients
rm -rf ~/snap/microstack/
rm -rf ~/snap/openstackclients/
sudo reboot
```

