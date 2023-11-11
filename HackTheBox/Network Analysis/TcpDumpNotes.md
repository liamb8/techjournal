# Tcpdump Overview

**Tcpdump** is a command-line utility available on Unix-like operating systems, serving as a crucial tool for network traffic analysis. It's designed to capture and inspect the data that flows through a system's network interfaces.

## Key Features

- **Network Analysis**: Tcpdump allows for comprehensive monitoring of network traffic, which is essential for troubleshooting and security audits.
- **Traffic Capture**: It can capture all kinds of network packets, including TCP, UDP, ARP, and ICMP.
- **Versatility**: With a variety of options and filters, tcpdump enables precise targeting, allowing administrators to focus on specific traffic types or patterns.
- **Troubleshooting**: It's a go-to solution for network administrators to diagnose and resolve network issues.

Tcpdump's functionality is not limited to capturing TCP traffic; it can handle multiple protocol types, making it a versatile tool for diverse networking tasks.



### **Lists available interfaces**

```
tcpdump -D
```

### Capture packets on a specific interface (e.g., eth0)

```
tcpdump -i eth0
```

### Use basic capture filters

```
tcpdump -i <interface> -vX
```

### Save a capture to a .pcap file

```
tcpdump -i <interface> -nvw /home/pcaps/netcap.pcap
```

> **Note:** The `-n` option prevents the conversion of addresses to names.

### Read a capture from a .pcap file

```
tcpdump -nnSXr /home/pcaps/netcap.pcap
```

### Examples of tcpdump filters

- **Host Filter**

  ```
  sudo tcpdump -i eth0 host 192.168.100.2
  ```

- **Source/Destination Filter**

  ```
  sudo tcpdump -i eth0 src host 192.168.100.2
  ```

- **Source with Port Filter**

  ```
  sudo tcpdump -i eth0 tcp src port 80
  ```

- **Destination/Network Filter Combination**

  ```
  sudo tcpdump -i eth0 dest net 172.16.146.0/24
  ```

- **Protocol Filter**

  ```
  sudo tcpdump -i eth0 tcp
  ```

  > Can also use `udp` or `icmp`.

- **Protocol Number Filter**

  ```
  sudo tcpdump -i eth0 proto 17
  ```

- **Port Filter**

  ```
  sudo tcpdump -i eth0 tcp port 22
  ```

- **Port Range Filter**

  ```
  sudo tcpdump -i eth0 portrange 0-1024
  ```

  > Can use range `0-65535`.

- **Less/Greater Than Filter**

  ```
  sudo tcpdump -i eth0 less 64
  ```

  ```
  sudo tcpdump -i eth0 greater 300
  ```

  > Shows only packets larger than 300 bytes.

- **Combine Filters with 'and'**

  ```
  sudo tcpdump -i eth0 host 192.168.100.2 and port 22
  ```

- **Basic Capture with No Filter**

  ```
  tcpdump -i eth0
  ```

- **Combine Filters with 'or'**

  ```
  sudo tcpdump -r suspicious.pcap icmp or host 192.168.100.2
  ```

- **Exclude Traffic with 'not'**

  ```
  sudo tcpdump -r suspicious.pcap not icmp
  ```

- **Piping Capture Output to Grep**

  ```
  sudo tcpdump -Ar http.cap -l | grep 'mailto:*'
  ```

  > The `-l` option passes the output to grep, which filters for instances of `mailto:*`.