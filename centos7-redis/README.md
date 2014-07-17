## Redis Vagrant Machine on Centos 7.0 

After running 

```bash
vagrant up
```

vagrant first imports base Centos 7.0 machine and starts provisioning using puppet.

Puppet script 

1. installs epel repositories 
2. installs Redis
3. modifies Redis config on /etc/redis.conf to listen on all interfaces

Vagrant box uses nat networking and it forwards the local redis port 6379 to guest machines port 6379.
Redis will be listening on localhost 6379.

To control redis
```bash
service redis-server (start|stop|restart|status)
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

