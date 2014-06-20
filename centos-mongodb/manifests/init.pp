node default {
   include base
}

class base {
   yumrepo { "mongodb.repo":
      baseurl => "http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/",
      descr => "MongoDB repository",
      enabled => 1,
      gpgcheck => 0
   }
}

package { 'mongodb-org':
   ensure => installed,
   require => Yumrepo["mongodb.repo"],
}

iptables::allow { 'tcp/27017': port => '27017', protocol => 'tcp' }
iptables::allow { 'tcp/28017': port => '28017', protocol => 'tcp' }

file_line { 'modify_mongod_conf':
  path  => '/etc/mongod.conf',
  line  => 'bind_ip=0.0.0.0',
  match => '^bind_ip.*',
  require => Package['mongodb-org'],
}

file { "/etc/mongod.conf":
  notify => Service["mongod"],
  require => Package['mongodb-org'],
}

service { 'mongod':
      name      => 'mongod',
      ensure    => running,
      enable    => true,
      require => Package['mongodb-org'],
}
