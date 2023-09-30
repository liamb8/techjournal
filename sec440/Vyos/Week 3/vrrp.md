vyos1:

```
set high-availability vrrp group hagroup11 vrid 176
set high-availability vrrp group hagroup11 interface eth2
set high-availability vrrp group hagroup11 virtual-address 10.0.6.10/24
set high-availability vrrp group hagroup11 priority 200
```

vyos2:

```
set high-availability vrrp group hagroup11 vrid 176
set high-availability vrrp group hagroup11 interface eth2
set high-availability vrrp group hagroup11 virtual-address 10.0.6.10/24
set high-availability vrrp group hagroup11 priority 50
```

