## Cassandra Vagrant Machine on Centos 6.5

After running 

```bash
vagrant up
```

vagrant first imports base Centos 6.5 machine and starts provisioning using puppet.

Puppet script 

1. adds datastax repository 
2. installs Oracle Jdk
3. installs Cassandra
4. starts Cassandra service

Vagrant box uses NAT networking and sets port forwarding on guest:9160 to localhost:9161

To control cassandra
```bash
sudo service cassandra (start|stop|restart|status)
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

