# Final Project Lab 

## VPC Setup:
Under Name tag:
* Add a name for the vpc like “FinalProjVPC”

Under IPv4 CIDR:

* Add the subnet address which is “10.10.0.0/16” this will be used for both the public and private route tables.
![VPC Settings](https://github.com/liamb8/CloudAdmin-Deploy/blob/main/Photos/VPCSettings.JPG)

## **Internet Gateway Setup:**

Under Name tag:

* Add a name to identify the Internet Gateway like “FinalProjGateway”
![Internet Gateway](https://github.com/liamb8/CloudAdmin-Deploy/blob/main/Photos/InternetGateway.JPG)

## Route Table Setup:
Under Name:
* Add a name to label the Route Table like “PubRouteTable” and “PrivRouteTable”
* Then select the VPC created earlier as “FinalProjVPC”
* Click “Create Internet Gateway”
* Under **Actions** 
  * Select **Edit subnet associations**
    * Select “PubSubnet” or “PrivSubnet” this will associate the route table with that specific subnet

![Route Table](https://github.com/liamb8/CloudAdmin-Deploy/blob/main/Photos/RouteTable.JPG)



## **Create Instances**

Under **Services** go to **EC2** then go to the **EC2 Dashboard** then click on **Launch Instance.** This will bring up a list of VMs to create after this select “**Amazon Linux 2 AMI (HVM)”** then press **select.** Make sure under the **Type** “Free tier eligible” is there. After confirming this select **“Next: Configure Instance Details”** under this select the **Network VPC** as **“FinalProjVPC”.** Under **Subnet** select **PubSubnet** or **PrivSubnet.** Then under **Auto-assign Public IP** select “enable” if creating a public vm if not leave it as disabled. After this click **Review and Launch** and then there will be a warning at the top in that warning box click **Edit security groups**. Create a new security group or select an existing one. Repeat this process for all 3 vms created. 



## **NAT Gateway Instance/SSH-Jumpbox Setup:**

Make sure the security group for the SSH-Jumpbox has the following rules:

- **Inbound**

- - **All ICMP v4 from Anywhere**
  - **SSH for IPv4 Anywhere**
  - **All TCP from your PRIVATE Subnet IP network only**
  - **All UDP from your PRIVATE Subnet IP network only**

- **Outbound** 

- - **All traffic to all destinations (should be default)**



**Run the following commands to configure your instance as a NAT server:**

```
sudo sysctl -w net.ipv4.ip_forward=1

sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sudo yum install iptables-services

sudo service iptables save
```



**Update Private Subnet Routing Table to use NAT Gateway:**

PrivateRouteTable: Add a route to allow the private subnet to connect to the public subnet, the Internet, and other private subnets.

Select **PrivateRouteTable** from the list.

Go to **Routes tab**, click on **Edit routes**

Specify the following values:

- Destination: 0.0.0.0/0
- Target: Select Instance from the dropdown menu to select the NAT Instance id #

Click on **Save routes**



## **Setting up LAMP Stack:**

**Linux-Apache-PHP VM:**

**Apache Install:**

```
sudo yum install httpd

sudo systemctl start httpd

sudo systemctl enable httpd
```

**PHP Install:**

```
sudo yum install php php-mysql

sudo systemctl restart httpd
```

**MySQL VM:**

```
sudo yum install mariadb-server mariadb

sudo systemctl start mariadb

sudo mysql_secure_installation

sudo systemctl enable mariadb
```

# **Part 2:**

## **Setup CloudWatch:**

**Enable detailed monitoring for an existing instance:**

1. Open the Amazon EC2 console by going through AWS Educate and to your AWS Console
2. In the EC2 Console navigation pane, choose Instances.
3. Select your instance and choose Actions, Monitor and Troubleshoot, Manage detailed monitoring.
4. On the Detailed monitoring detail page, for Detailed monitoring, select the Enable check box.
5. Choose Save.

**Create an alarm using the Amazon EC2 console**

1. Go to your Amazon EC2 console 

2. In the navigation pane, choose Instances.

3. Select the instance and choose Actions, Monitoring and Troubleshoot, Manage CloudWatch alarms.

4. On the Manage CloudWatch alarms detail page, under Add or edit alarm, select Create a new alarm.

5. For Alarm notification,you can toggle off to configure Amazon Simple Notification Service (Amazon SNS) notifications for now.

6. For Alarm action, Review the options so you can see what actions could be available - but for this lab we will toggle off.

7. For Alarm thresholds, use the NetworkPacketsIn metric

8. - Group Samples by Average
   - Criteria is greater than or equal 10 packets (for some reason, in testing it was showing "Bytes" above the packet count filed - but when the alarm was created, it was correct. It was likely a JavaScript issue
   - For Consecutive period, enter 1. For Period, select 5 minutes.

9. Choose Create

**Setup CloudTrail:**

1. On the CloudTrail Dashboard page, choose **Create trail**.
2. In Trail name, give your trail a name, such as **FinalProj-Management-Events-Trail**.
3. Leave default settings for AWS Organizations organization trails.
4. For **Storage location**, choose **Create new S3 bucket** to create a bucket. Give your bucket a name, such as FinalProj-bucket-for-storing-cloudtrail-logs. The name of your Amazon S3 bucket must be globally unique. 
5. Clear the check box to disable **Log file SSE-KMS encryption**.
6. Leave default settings in **Additional settings**.
7. On the **Choose log events** page, select event types to log. 
8. Leave default settings for **Data events** and Insights events. Choose **Next**.
9. On the **Review and create** page, review the settings you've chosen for your trail. Choose **Edit** for a section to go back and make changes. When you are ready to create your trail, choose **Create trail**.

**Link CloudTrail to CloudWatch:**

1. Review the setting of your existing Trail
2. Find the Edit button for CloudWatch and click 
3. Enable CloudWatch logging
4. Create a New log group
5. Create a New IAM Role
6. Save 

**Setup TLS for Apache:**

Navigate to your home directory (/home/ec2-user). Download EPEL with the following command.

`sudo wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/`

`sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm`

`sudo yum-config-manager --enable epel*`

Edit the main Apache configuration file, /etc/httpd/conf/httpd.conf. Locate the "Listen 80" directive and add the following lines after it, replacing the example domain names with the actual Common Name and Subject Alternative Name (SAN) for your Freenom registration.

````
<VirtualHost *:80>`

  `DocumentRoot "/var/www/html"`

  `ServerName "example.com"`

`ServerAlias "www.example.com"`

`</VirtualHost>
````

`sudo systemctl restart httpd`

`sudo yum install -y certbot python2-certbot-apache`

`sudo certbot`

**Go through the next certbot steps**

**Freenom Domain Registration:**

1. Go to Services -> Register a new domain.

2. Enter the desired domain name and check it’s availability.

3. Continue with the checkout process and select Use Freenom DNS when prompted

4. Add the Public IP address of your EC2 server to the A Records

5. - lb-sys360.gq public-ip-address
   - www.lb-sys360.gq public-ip-address
