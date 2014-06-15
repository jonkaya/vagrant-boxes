
#Install Development Tools
class misc {

  File {
      owner   => "vagrant"
    , group   => "vagrant"
    , mode    => 644
  }

  exec { "grap-epel":
      command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    , creates => "/etc/yum.repos.d/epel.repo"
    , alias   => "grab-epel"
  }

  package { "vim-enhanced":
      ensure  => present
  }

  # Reference: http://projects.puppetlabs.com/issues/5175
  exec { 'group-install':
      unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"'
    , command => '/usr/bin/yum -y groupinstall "Development tools"'
    , user => root
  }

  # yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
  package { "zlib-devel":
      ensure  => present
  }

  package { "bzip2-devel":
      ensure  => present
  }

  package { "openssl-devel":
      ensure  => present
  }

  package { "ncurses-devel":
      ensure  => present
  }

  package { "sqlite-devel":
      ensure  => present
  }

  package { "readline-devel":
      ensure  => present
  }

  package { "tk-devel":
      ensure  => present
  }

  package { "dos2unix":
      ensure  => present
  }

}


# Install PostgreSQL 9.3 server from the PGDG repository
class {'postgresql::globals':
  version => '9.3',
  manage_package_repo => true,
  encoding => 'UTF8',
  locale  => 'en_US.utf8',
}

class { 'postgresql::server':
  ensure => 'present',
  listen_addresses => '*',
  manage_firewall => true,
  postgres_password => 'postgres',
}

# Install contrib modules
class { 'postgresql::server::contrib':
  package_ensure => 'present',
}

#create db and configure user
postgresql::server::db { 'test':
  user     => 'dev',
  password => postgresql_password('dev', 'dev'),
}

postgresql::server::pg_hba_rule { 'allow application network to access app database':
  description => "Open up postgresql for access from 0.0.0.0/0",
  type => 'host',
  database => 'test',
  user => 'dev',
  address => '0.0.0.0/0',
  auth_method => 'trust',
}

#Install rest of the packages
include misc
