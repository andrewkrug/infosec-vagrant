package { ['httpd','mariadb-server']:
	ensure => present,
}

service { ['httpd','mariadb']:
	ensure => running,
	enable => true,
	hasrestart => true,
	hasstatus => true,
	require => Package['httpd','mariadb-server']
}

file { '/etc/sysconfig/iptables':
	ensure => present,
	notify => Service ['iptables'],
	content => '#Begin
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
#END',
}

service { iptables:
	ensure => running,
	enable => true,
	hasrestart => true,
	hasstatus => false,
}