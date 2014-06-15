## Postgresql 9.3 Vagrant Machine on Centos 6.5

After running 

```bash
vagrant up
```

vagrant first imports base Centos 6.5 machine and starts provisioning using puppet.

Puppet script 

1. installs required development packages
2. installs Postgresql 9.3
3. creates an initial db called test
4. gives access to dev user on test db
5. changes hba entry for db to be connected from any network.

Vagrant box uses bridged networking so it gets the next ip address from dhcp provider on your local network.
Postgresql will be listening on the local network ip address of your machine.

#####Credentials for database
*These values can be changed from the init.pp script*

**Username:** dev

**Password:** dev

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

