```
set nat destination rule 10 translation address '10.0.6.10'

set nat source rule 20 outbound-interface eth0
set nat source rule 20 address 10.0.6.0/24
set bat source rule 20 translation address masquerade

```

