Vyos1:

```
set high-availability vrrp group langroup11 vrid 175
set high-availability vrrp group langroup11 interface eth1
set high-availability vrrp group langroup11 virtual-address 10.0.5.1/24
set high-availability vrrp group langroup11 priority 200

set high-availability vrrp group wangroup11 vrid 161
set high-availability vrrp group wangroup11 interface eth1
set high-availability vrrp group wangroup11 virtual-address 10.0.17.111/24
set high-availability vrrp group wangroup11 priority 200
```

Vyos2:

```
set high-availability vrrp group langroup11 vrid 175
set high-availability vrrp group langroup11 interface eth1
set high-availability vrrp group langroup11 virtual-address 10.0.5.1/24
set high-availability vrrp group langroup11 priority 50

set high-availability vrrp group wangroup11 vrid 161
set high-availability vrrp group wangroup11 interface eth1
set high-availability vrrp group wangroup11 virtual-address 10.0.17.111/24
set high-availability vrrp group wangroup11 priority 50
```

