class selinux ($mode='disabled') inherits selinux::params {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  package { $selinux::params::selinux_utils:
    ensure => present,
  }

  $current_mode = $::selinux? {
    bool2boolstr(false) => 'disabled',
    false               => 'disabled',
    default             => $::selinux_current_mode,
  }

  file { '/etc/selinux/config':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template("${module_name}/config.erb"),
    require => Package[$selinux::params::selinux_utils],
  }

  if($current_mode != $mode)
  {
    case $mode
    {
      'enforcing':
      {
        case $current_mode
        {
          default: { fail('i\'m too lazy to implement this') }
        }
      }
      'disabled':
      {
        case $current_mode
        {
          'enforcing':
          {
            notify { 'Reboot required to disable SELinux, setting permissive instead': }

            exec { "setenforce ${mode}":
              command => 'setenforce 0',
              require => Package['libselinux-utils'],
            }
          }
          'permissive':
          {
            notify { "Reboot required to disable SELinux, current mode: ${current_mode}": }
          }
          default: { fail('i\'m too lazy to implement this') }
        }
      }
      'permissive':
      {
        case $current_mode
        {
          'enforcing':
          {
            exec { "setenforce ${mode}":
              command => 'setenforce 0',
              require => Package['libselinux-utils'],
            }
          }
          default: { fail('i\'m too lazy to implement this') }
        }
      }
      default: { fail('the fuck is this fuckery? - supported modes: enforcing, permissive and disabled') }
    }
  }
}
