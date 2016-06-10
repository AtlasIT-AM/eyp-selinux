class selinux::params {

  case $::osfamily
  {
    'redhat':
    {
      $selinux_utils='libselinux-utils'
      case $::operatingsystemrelease
      {
        /^[6-7].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $selinux_utils='selinux-utils'
      case $::operatingsystem
      {
      'Ubuntu':
      {
        case $::operatingsystemrelease
        {
          /^14.*$/:
          {
          }
          default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
        }
      }
      'Debian': { fail('Unsupported')  }
      default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
