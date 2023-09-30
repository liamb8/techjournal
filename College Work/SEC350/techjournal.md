# Routing on vyOS Firewall
When using the terminal on vyOS you have to start it by typing `configure` first. After doing any changes to save them you need to type `commit` then `save` in order to fully save the configuration. When done with configuration type `exit` to leave the terminal. To set the system hostname type `set system host-name fw1-yourname`. Using accurate hostnames is very important for security logging and monitoring purposes. 

If eth0 is configured with dhcp it needs to be deleted as we're using a static IP Address and not a dynamic one. You can delete the dhcp address by issuing the command `delete interfaces ethernet eth0 address dhcp`. When adding new IP Addresses to interfaces you can use the command `set interfaces eth0 address 10.0.16.142/24`repeat for other interfaces. To set a description for an interface use the command `set interfaces ethernet eth0 description SEC350-WAN`.

**Here you can see the interfaces on vyOS setup correctly**  

![](https://github.com/liamb8/techjournal/blob/master/Pictures/rsz_interfaces.jpg) 

When setting up the **Gateway and DNS** these are the commands to use. `set protocols static route 0.0.0.0/0 next-hop 10.0.17.2` then when setting up the name server do `set system name server 10.0.17.2`. Don't forget when saving changes you need to do `commit` then `save`.

Next, you need to configure the firewall for NAT and DNS forwarding. The commands to do this are:

`set nat source rule 10 description "NAT SOURCE RULE DMZ to WAN"`  
`set nat source rule 10 outbound-interface eth0`  
`set nat source rule 10 source address 172.16.50.0/29`  
`set nat source rule 10 translation address masquerade`  
`commit` and `save`

This can be confirmed by successfully pinging 8.8.8.8 (google IP) to check internet connection.

To configure DNS forwarding now do the following commands:  
`set service dns forwarding listen-address 172.16.50.2`  
`set service dns forwarding allow-from 172.16.50.0/29`  
`commit` and `save`


### Setting up Networking on CentOS7
When setting up networking on CentOS7 easiest way is to use `nmtui` and input the networking information in there. To add ports to the firewall on CentOS use `sudo firewall-cmd --zone=public --permanent --add-port=443/tcp`. Listing all the ports `sudo firewall-cmd --list-all`.

# Configuring Logging
Make sure to have port 514/udp and 514/tcp open on Log01 firewall. 

Useful code to dynamically create and name files based upon hostname, date and process name.  
`module(load="imudp")`  
`input(type="imudp" port="514" ruleset="RemoteDevice")`  
`template(name="DynFile" type="string"`

`string="/var/log/remote-syslog/%HOSTNAME%/%$YEAR%.%$MONTH%.%$DAY%.`  
`%PROGRAMNAME%.log"`  
`)`  
`ruleset(name="RemoteDevice"){`  
	`action(type="omfile" dynaFile="DynFile")`  
`}`

Copy this file to the `/etc/rsyslog.d/` directory

When sending logs make sure to send it to log01 IP address or wherever splunk is installed. On CentOS 7 you can do this in /etc/rsyslog.d/ where the sec350.conf was created.  
![](https://github.com/liamb8/techjournal/blob/master/Pictures/rsz_authpriv.jpg)

When setting up logging on vyOS you use these commands:  
`set system syslog host 172.16.200.10 facility authpriv level info`  
`commit` and `save`

### Setting up Splunk on CentOS 7

**Starting Splunk for the first time:**  
`cd /opt/splunk/bin`  
`./splunk start -accept-license`  
`./splunk enable boot-start`

Allow Splunk's WebUI port 8000/tcp on the CentOS firewall.  
`sudo firewall-cmd --zone=public --permanent --add-port=8000/tcp`

### Different SSH Login Events Recorded On Splunk:
![](https://github.com/liamb8/techjournal/blob/master/Pictures/rsz_log.png)