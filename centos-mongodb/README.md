## Mongodb Vagrant Machine on Centos 6.5

After running 

```bash
vagrant up
```

vagrant first imports base Centos 6.5 machine and starts provisioning using puppet.

Puppet script 

1. installs mongodb repositories 
2. installs mongodb
3. adds firewall rules to access port 27017
4. modifies Redis config on /etc/mongod.conf to listen on all interfaces

Vagrant box uses bridged networking so it gets the next ip address from dhcp provider on your local network.
Mongodb will be listening on the local network ip address of your machine.

To control redis
```bash
service mongod (start|stop|restart|status)
```

Following command may be used for logging in the machine
```bash
vagrant ssh
```

If you like to suspend the machine
```bash
vagrant suspend
```

Or if you like to delete it completely
```bash
vagrant destroy
```

