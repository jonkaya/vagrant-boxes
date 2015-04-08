node default {
   include base
   include jdk_oracle
}

class base {
   yumrepo { "datastax.repo":
      baseurl => "http://rpm.datastax.com/community",
      descr => "Datastax repository",
      enabled => 1,
      gpgcheck => 0
   }
}

package { 'dsc20':
   ensure => installed,
   require => Yumrepo["datastax.repo"],
}

package { 'opscenter':
   ensure => installed,
   require => Yumrepo["datastax.repo"],
}

package { 'jna':
   ensure => installed,
}

package { 'wget':
   ensure => installed,
}




file_line { 'modify_cassandra_conf':
  path  => '/etc/cassandra/conf/cassandra.yaml',
  line  => 'rpc_address: 0.0.0.0',
  match => '^rpc_address.*',
  require => Package['dsc20'],
}

file { "/etc/cassandra/conf/cassandra.yaml":
  notify => Service["cassandra"],
  require => Package['dsc20'],
}


iptables::allow { 'tcp/9160': port => '9160', protocol => 'tcp' }
iptables::allow { 'tcp/8888': port => '8888', protocol => 'tcp' }
iptables::allow { 'tcp/7199': port => '7199', protocol => 'tcp' }

service { 'cassandra':
      name      => 'cassandra',
      ensure    => running,
      enable    => true,
      require => Package['dsc20'],
}

service { 'opscenterd':
      name      => 'opscenterd',
      ensure    => running,
      enable    => true,
      require => Package['opscenter'],
}

