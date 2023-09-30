SSH Config:

Open `/etc/pam.d/sshd` with sudo privileges, and add the following lines to the end of the file:

`auth    required      pam_unix.so     no_warn try_first_pass`   
`auth    required      pam_google_authenticator.so`



File: /etc/ssh/sshd_config

##### This line already exists in the file, and should be changed from 'no' to 'yes'
`ChallengeResponseAuthentication yes`

...

##### These lines should be added to the end of the file.

Replace example-user with a system user.

`Match User example-user`   

`AuthenticationMethods keyboard-interactive`



2 Factor Auth Config:



1. To install the necessary packages enable the EPEL repository, which hosts the package you’re looking for.

   ```
    sudo yum install wget
    sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo rpm -Uvh epel-release-latest-7.noarch.rpm
   ```

2. Next, install the google-authenticator package that you’ll be using to generate keys and passwords.

   ```
    sudo yum install google-authenticator
   ```

3. Run the `google-authenticator` program. A prompt will appear asking you to specify whether you’d like to use time-based authentication (as opposed to one-time or counter-based). Choose “yes” by entering `y` at the prompt.

```
google-authenticator
```

 

After this Scan the QR code that shows up or manually input the secret key that is generated. After this follow through the next steps.

[Resource](https://www.linode.com/docs/guides/how-to-use-one-time-passwords-for-two-factor-authentication-with-ssh-on-centos/)

