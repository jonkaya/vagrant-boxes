exec { "grap-epel":
      command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm"
    , creates => "/etc/yum.repos.d/epel.repo"
    , alias   => "grab-epel"
}

package { 'redis':
	ensure => installed,
}

file_line { 'modify_redis_conf':
  path  => '/etc/redis.conf',
  line  => 'bind 0.0.0.0',
  match => '^bind\s+.*',
  require => Package['redis'],
}

file { "/etc/redis.conf":
  notify => Service["redis-server"],
  require => Package['redis'],
}

service { 'redis-server':
      name      => 'redis-server',
      ensure    => running,
      enable    => true,
      require => Package['redis'],
}
