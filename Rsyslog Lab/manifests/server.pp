package { 'rsyslog':
	ensure => present,
}

file { '/etc/rsyslog.d/remote.conf':
	ensure => present,
	notify => Service['rsyslog'],
	content =>'# ######### Receiving Messages from Remote Hosts ##########
# TCP Syslog Server:
# provides TCP syslog reception and GSS-API (if compiled to support it)
$ModLoad imtcp.so  # load module
$InputTCPServerRun 514 # start up TCP listener at port 514

# UDP Syslog Server:
$ModLoad imudp.so  # provides UDP syslog reception
$UDPServerRun 514 # start a UDP syslog server at standard port 514
$template DailyPerHostLogs,"/var/log/%FROMHOST-IP%/%$YEAR%%$MONTH%%$DAY%-%HOSTNAME%.log"
*.* -?DailyPerHostLogs
'
}

service { 'rsyslog':
	ensure => running,
	enable => true,
	hasrestart => true,
	hasstatus => true,
}