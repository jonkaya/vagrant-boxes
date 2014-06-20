exec { "grap-epel":
      command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    , creates => "/etc/yum.repos.d/epel.repo"
    , alias   => "grab-epel"
  }

class { 'yum':
  extrarepo => [ 'epel', 'remi'],
}

package { 'redis':
	ensure => installed,
}

iptables::allow { 'tcp/6379': port => '6379', protocol => 'tcp' }

file_line { 'modify_redis_conf':
  path  => '/etc/redis.conf',
  line  => 'bind 0.0.0.0',
  match => '^bind\s+.*',
  require => Package['redis'],
}

file { "/etc/redis.conf":
  notify => Service["redis"],
  require => Package['redis'],
}

service { 'redis':
      name      => 'redis',
      ensure    => running,
      enable    => true,
      require => Package['redis'],
}
