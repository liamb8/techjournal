# OpenStack Deploy



## Reflection

I think having the chance to setup and use physical hardware this time was a good experience. In many of the other classes taken at Champlain we use hardware that was mostly virtual and didn't have to set it up for the most part ourselves. It was a really enjoyable experience and I wish I had more chances to do this in other courses. 

## Install OpenStack

Install the MicroStack snap:

```
sudo snap install microstack --devmode --beta
```

Install MicroStack automatically using this command:

```
sudo microstack init --auto --control
```

Create a new instance called test:

```
microstack launch cirros -n test
```

After creating an instance login to OpenStack through the web browser using `https://10.20.20.1`. The username is `admin` and you can get the password using `sudo snap get microstack config.credentials.keystone-password`.

