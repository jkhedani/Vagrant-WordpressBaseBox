$config_path = "/puppet/configs"
$vagrant_base_path = "/vagrant"
Exec { path => "/bin:/usr/bin:/usr/local/bin" }
group { "puppet": ensure => present }
exec { "apt-get update": command => "apt-get update" }
class apache {
    file { "/etc/apache2/sites-enabled/000-default":
        ensure => file,
        source => "${config_path}/000-default",
        before => Service["apache2"],
    }
    exec { "enable-mod_rewrite":
        require => Package["apache2"],
        before => Service["apache2"],
        command => "/usr/sbin/a2enmod rewrite"
    }
    package { "apache2":
        ensure => present,
        before => File["/etc/apache2/sites-enabled/000-default"],
    }

    service { "apache2":
        ensure => running,
        require => Package["apache2"]
    }
}
class php {
    package { "libapache2-mod-php5": ensure => present }
    package { "php5": ensure => present }
    package { "php5-gd": ensure => present }
    package { "php5-cli": ensure => present }
    package { "php5-dev": ensure => present }
    package { "php5-mcrypt": ensure => present }
    package { "php5-mysql": ensure => present }
    package { "php-pear": ensure => present }
    exec { "pear upgrade":
        command => "/usr/bin/pear upgrade",
        require => Package["php-pear"],
    }
}
class mysql {
  package { "mysql-server":
    require => Exec["apt-get update"],
    ensure => present,
  }
  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }
  exec { "Set MySQL server root password":
        require => Package["mysql-server"],
        unless => "/usr/bin/mysqladmin -uroot -proot status",
        command => "/usr/bin/mysqladmin -uroot password root",
  }
}
include apache
include php
include mysql
include phpmyadmin