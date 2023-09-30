# **Tech Journal**

## **Lab 2-1**
### Subnet:
![](https://github.com/liamb8/networking/blob/master/subnet.JPG)

### Notes:
Adding VLANs to switches by using the VLAN database and putting in the number that corresponds to the VLAN for that certain subnet you want to use. By using access those on the same VLAN can only ping those within the same VLAN, unlike trunked ports that can access all other VLANs.

An easy way to change a large number of interfaces at once is **`(config)interface range FastEthernet 0/x-y`**

To change the specific interfaces to a certain VLAN you can use **`(config-if-range)switchport access vlan x`**

## **Lab 3-3**

### Creating DHCP Pools:
DHCP Pools are used for assigning IP Addresses and Subnet Masks to the proper hosts which are requesting to lease an IP Address on that specific subnet. To create a DHCP Pool follow the steps below. 

To use DHCP you need a server and then go into the services tab and turn it on.  
`Pool Name`  
`Default Gateway (Router Address for that VLAN)`  
`DNS (Leave at 0.0.0.0 if no DNS server)`  
`Start IP Address (Start at 20, 50, or 100)`  
`Subnet Mask (VLAN Subnet Mask)`  
`Maximum Users`  
`TFTP (leave at 0.0.0.0)`

### Using serverPool:
serverPool is used for the DHCP server own network subnet (MGMT). Same steps to set up as creating a DHCP Pool just instead you're using the Management network. 

### IP Helper Addresses:
IP Helper Addresses are used to help direct traffic to the DHCP server in order to receive an IP Address from it. Without this, any computer trying to use DHCP won't be able to find it's way to the DHCP Server and lease an IP Address. 

Command: `ip helper-address (DHCP Server IP)`

## **Lab 4-1**
Setting up a Small Enterprise Network with VLANs, DHCP, DNS. Using Single Distribution Area as the network layout. 

![](https://i.imgur.com/JIiICUd.png)
![](https://i.imgur.com/kwj4zEb.png)

## **Lab 5-1**
### **Setting up NAT**  
`interface fastEthernet 0/0`  
`ip nat inside`  
`exit`  
`interface serial 0/0/0`  
`ip nat outside`  
`exit`  
`ip nat inside source static 10.0.0.2 50.0.0.1`

## **Lab 5-2**
### **NAT PAT**
Configure the Inside and Outside interfaces. Follow the Lab 5-1 Setting up NAT to configure the inside and outsides interfaces.   

Creates an address pool called test for the 192.168 clients and only has one IP address in the table (30.0.0.120).  
`ip nat pool test 30.0.0.120 30.0.0.120 netmask 255.0.0.0`  

Creates an access list which defines what internal IP's can use the Public IP pool defined as test  
`access-list 1 permit 192.168.0.0 0.0.0.255`  

Assigns a pool and access rule to the inside NAT interface. It allows the 192.168 IP addresses to be translated to the PAT IP from the pool test when it goes from the inside NAT interface to the outside NAT interface. Having overload lets an IP be used by many clients (up to 64,000).   
`ip nat inside source list 1 pool test overload`  

### **Editing Protocol Filter in Simulation Mode**
Click Simulation (Right Side of Screen) --> Edit Filters

![](https://imgur.com/2WrFNxu.png)

 Assign pool and access rule to interface with nat statement - basically saying that access-list 1 (192.168 addresses) can be translated to the PAT IP' from pool "test" when going from the "inside" to "outside". Overload states that the IP can be used by many (up to 64,000) clients.

## **Lab 7-1**  
### **Configuring OSPF**  
`router ospf 10 (id must be the same for every rotuer)`  
`network 172.16.0.2 0.0.0.255 area 0` (network directly connected networks to the router interfaces)  

## **Lab 8-2**  
### **Configuring BGP**  
`router bgp 2054` (AS Number for that specific router)  
`neighbor 192.168.1.1 remote-as 1010` (neighbor is the adjacent router interfaces IP address and AS number is that routers specific one)  