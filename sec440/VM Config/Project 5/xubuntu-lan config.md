xubuntu-lan config:

```
[Interface] 
ListenPort = 51900 
PrivateKey = HIDDEN 
Address = 10.0.101.2 
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens160 -j MASQUERADE [Peer] 
PublicKey = InsertPublicKey
AllowedIPs = 10.0.101.1/32 
Endpoint = ec2-3-88-197-168.compute-1.amazonaws.com:51900 
PersistentKeepAlive = 25 
```

aws-ubuntu-peer config:

```
[Interface] 
ListenPort = 51900 
PrivateKey = HIDDEN 
Address = 10.0.101.1 
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE [Peer] 
PublicKey = InsertPublicKey
AllowedIPs = 10.0.101.2/32, 10.0.6.0/24 
Endpoint = 10.0.5.6:51900

```





