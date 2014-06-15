##Ready Vagrant Boxes for Development

To use the machines first [Install Vagrant](https://docs.vagrantup.com/v2/installation/)
then [Install Puppet](http://docs.puppetlabs.com/guides/install_puppet/pre_install.html)

After installations finish and clone the repository, when 

After running

```bash
vagrant up
```
next to VagrantFile, vagrant first imports base box and starts provisioning using puppet.

Puppet script installs required development packages and brings up your machine.

Vagrant box uses bridged networking so it gets the next ip address from dhcp provider on your local network.

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
