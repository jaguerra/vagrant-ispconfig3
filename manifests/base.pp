file { "/etc/apt/sources.list.d/squeeze-backports.list":
    ensure  => file,
    owner   => root,
    group   => root,
    content => "deb http://backports.debian.org/debian-backports squeeze-backports main",
}

exec { "import-gpg":
    command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -"
}

exec { "/usr/bin/apt-get update":
    require => [File["/etc/apt/sources.list.d/squeeze-backports.list"], Exec["import-gpg"]],
}

class { "system": }

file { "/etc/motd":
    ensure  => file,
    mode    => "0644",
    owner   => "root",
    group   => "root",
    content => template("system/motd.erb"),
}

system::package { "build-essential": }
system::package { "curl": }
system::package { "git-core": }
system::package { "vim": }



system::config { "bashrc":
    name   => ".bashrc",
    source => "/vagrant/files/system/bashrc",
}

/* ISPConfig.. */
system::package { "ntp": }
system::package { "ntpdate": }
system::package { "rkhunter": }
system::package { "binutils": }
system::package { "postfix": }
system::package { "pure-ftpd-common": }
system::package { "pure-ftpd-mysql": }
system::package { "quota": }
system::package { "quotatool": }

system::package { "vlogger": }
system::package { "webalizer": }
system::package { "geoip-database": }

system::package { "fail2ban": }

system::package { "apache2-suexec": }
system::package { "libapache2-mod-fastcgi": }

system::package { "apache2-mpm-event": }


class { "apache": 
	purge_vdir => false,
	require     => Package["Tools_apache2-mpm-event"]
}


package { 'libapache2-mod-php5':
    ensure => absent,
    before => Package['httpd']
}
/*
class { "apache::mod::php":
    require => Package["php5"]
}
*/

class { "apache::mod::ssl": }

apache::mod { "rewrite": }
apache::mod { "headers": }
apache::mod { "fcgid": }
apache::mod { "suexec":
	require => Package["Tools_apache2-suexec"]
}
apache::mod { "actions": }
apache::mod { "include": }

apache::mod { "fastcgi": 
	require => Package["Tools_libapache2-mod-fastcgi"]
}

/*
apache::vhost { "ispconfig.local":
    priority    => "50",
    vhost_name  => "*",
    port        => "80",
    docroot     => "/var/www/vhosts/ispconfig.local/",
    serveradmin => "admin@ispconfig.local",
    template    => "system/apache-default-vhost.erb",
    override    => "All",
}
*/


class { "mysql":
    root_password => "root",
    require       => Exec["apt-update"],
}


class { "php": }

/*
file { "php5-ini-apache2-config":
    path    => "/etc/php5/apache2/php.ini",
    ensure  => "/vagrant/files/php/php.ini",
    require => Package["php5"],
}
*/

file { "php5-ini-cgi-config":
    path    => "/etc/php5/cgi/php.ini",
    ensure  => "/vagrant/files/php/php.ini",
    require => Package["php5"],
}


file { "php5-ini-cli-config":
    path    => "/etc/php5/cli/php.ini",
    ensure  => "/vagrant/files/php/php-cli.ini",
    require => Package["php5"],
}

php::module { "common": }
/*php::module { "dev": }*/

php::module { "mysql": }
php::module { "intl": }
php::module { "cli": }
php::module { "cgi": }
php::module { "gd": }
php::module { "xsl": }
php::module { "mcrypt": }
php::module { "curl": }
php::module { "imap": }
/*
php::module { "apc":
    module_prefix => "php5-",
}
*/
/*
php::module { "xcache": }
*/

