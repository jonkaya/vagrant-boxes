## Couchdb Vagrant Machine on Centos 6.5

After running 

```bash
vagrant up
```

vagrant first imports base Centos 6.5 machine and starts provisioning using puppet.

Puppet script 

1. enables epel repository 
2. installs couchdb
3. adds firewall rules to access port 5984
4. modifies Couchdb config on /etc/couchdb/local.ini to listen on all interfaces

Vagrant box uses bridged networking so it gets the next ip address from dhcp provider on your local network.
Couchdb will be listening on the local network ip address of your machine.

To control couchdb
```bash
service couchdb (start|stop|restart|status)
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

