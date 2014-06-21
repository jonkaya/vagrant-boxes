exec { "grap-epel":
      command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    , creates => "/etc/yum.repos.d/epel.repo"
    , alias   => "grab-epel"
}

package { 'couchdb':
   ensure => installed,
}

iptables::allow { 'tcp/5984': port => '5984', protocol => 'tcp' }

file_line { 'modify_couchdb_conf':
  path  => '/etc/couchdb/local.ini',
  line  => 'bind_address=0.0.0.0',
  match => '^.*bind_address.*',
  require => Package['couchdb'],
}

file { "/etc/couchdb/local.ini":
  notify => Service["couchdb"],
  require => Package['couchdb'],
}

service { 'couchdb':
      name      => 'couchdb',
      ensure    => running,
      enable    => true,
      require => Package['couchdb'],
}
