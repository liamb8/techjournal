## Installing MySQL

- Install MySQL server
  `sudo apt install mysql-server`
- Configure MySQL securely
  `sudo mysql_secure_installation`
- Repeat on the other servers

### Setting up Replication

- Log into MySQL
  `sudo mysql -u root -p`
- Generate UUID - Format should be "00000000-1111-2222-3333-444444444444"
  `SELECT UUID();`
- Record the UUID, as it is needed later
- Close out of MySQL
- Edit the /etc/mysql/my.cnf file
  `sudo vim /etc/mysql/my.cnf`
- Add to end of file

```
[mysqld]

server_id=1 
bind-address=0.0.0.0
gtid_mode=ON 
enforce_gtid_consistency=ON
binlog_checksum=NONE

plugin_load_add='group_replication.so'
group_replication_single_primary_mode=OFF
loose-group_replication_group_name="00000000-1111-2222-3333-444444444444"
loose-group_replication_start_on_boot=OFF
loose-group_replication_local_address= "server1_ip:33061"
loose-group_replication_group_seeds="dbserver1_ip:33061, dbserver2_ip:33061, dbserver3_ip:33061"
loose-group_replication_bootstrap_group=OFF
report_host=server1_ip
```

- Replace dbserver1_ip, dbserver2_ip, and dbserver3_ip with the IPs of the servers used
- Replace 00000000-1111-2222-3333-444444444444 with the UUID that was generated
- Restart MySQL

### Create Bootstrap Replication User

- Log into MySQL
- Create user - Replace EXAMPLE_PASSWORD with the password you want to use

```
SET SQL_LOG_BIN=0;
CREATE USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'EXAMPLE_PASSWORD';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;
CHANGE MASTER TO MASTER_USER='replication_user', MASTER_PASSWORD='EXAMPLE_PASSWORD' FOR CHANNEL 'group_replication_recovery';
```

- Bootstrap Group Replication

```
SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
```

- Turn off group_replication_bootstrap_group
  `SET GLOBAL group_replication_bootstrap_group=OFF;`
- Verify the replication group members
  `SELECT MEMBER_ID, MEMBER_HOST, MEMBER_STATE FROM performance_schema.replication_group_members;`

Repeat these steps on the other 2 boxes

After doing it on all 3 boxes finish out with these steps:

- `START GROUP_REPLICATION;`
- Verify the replication group members (All three servers should be there)
  `SELECT MEMBER_ID, MEMBER_HOST, MEMBER_STATE FROM performance_schema.replication_group_members;`
- Verify on server 2 and 3
  `SHOW DATABASES;`



## Install Wordpress

```
CREATE DATABASE wordpress;
```

- Give privileges to the replication user which was created before

```
GRANT ALL PRIVILEGES ON wordpress.* TO replication_user@%;
FLUSH PRIVILEGES;
```

### Install Wordpress and PHP

Do the following steps on web01 and web02:

```
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
```

- Copy sample config of Wordpress to Apache directory `sudo cp wp-config-sample.php /var/www/html/wp-config.php`
- Gives ownership to Apache user and group `sudo chown -R apache:apache /var/www/html/*`
- Edit the httpd.conf file in /etc/httpd/conf/
  `AllowOverride None -> AllowOverride All`

```
sudo yum install epel-release yum-utils

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum-config-manager --enable remi-php73

yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
```

### Configure Wordpress

Edit /var/www/html/wp-config.php

```
/** Database name for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL DB username */
define('DB_USER', 'replication_user');

/** MySQL DB password */
define('DB_PASSWORD', 'password');
```

Change 'password' to the password set for replication_user then restart httpd

### SELinux Config Change

Allows http connection with MySQL database

```
setsebool -P httpd_can_network_connect_db=1

systemctl restart httpd
```