#!!!! This avc can be allowed using the boolean 'daemons_dump_core'
selinux::setbool { 'daemons_dump_core':
  value => true,
}

#!!!! This avc can be allowed using the boolean 'nagios_run_sudo'
selinux::setbool { 'nagios_run_sudo':
  value => true,
}

#!!!! This avc can be allowed using the boolean 'nis_enabled'
selinux::setbool { 'nis_enabled':
  value => true,
}

exec { 'nrpe selinux dir':
  command => 'mkdir -p /usr/local/src/nrpe/selinux',
  creates => '/usr/local/src/nrpe/selinux',
}

file { '/usr/local/src/nrpe/selinux/nrpe_monit.te':
  ensure  => 'present',
  owner   => 'root',
  group   => 'root',
  mode    => '0400',
  content => file("${module_name}/nrpe_demo/nrpe_monit.te"),
  require => Exec['nrpe selinux dir'],
}

selinux::semodule { 'nrpe_monit':
  basedir => '/usr/local/src/nrpe/selinux',
  require => File['/usr/local/src/nrpe/selinux/nrpe_monit.te'],
}
