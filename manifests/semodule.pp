#
# $ checkmodule -M -m -o puppetmaster.mod /path/to/your/version/controlled/module.te
# $ semodule_package -m module.mod -o module.pp
# $ semodule -i module.pp
#
define selinux::semodule(
                          $modulename = $name,
                          $basedir    = '/usr/local/src/selinux',
                          $ensure     = 'installed',
                        ) {
  #
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "mkdir p ${basedir} $modulename":
    command => "mkdir -p ${basedir}",
    creates => $basedir,
  }

  # $ checkmodule -M -m -o puppetmaster.mod /path/to/your/version/controlled/module.te
  exec { "checkmodule ${modulename}":
    command => "checkmodule -M -m -o ${basedir}/${modulename}.mod ${basedir}/${modulename}.te",
    creates => "${basedir}/${modulename}.mod",
    require => Exec["mkdir p ${basedir} $modulename"],
    notify => Exec["semodule ${modulename}"],
  }

  if(defined(File["${basedir}/${modulename}.te"]))
  {
    Exec["checkmodule ${modulename}"] {
      subscribe => File["${basedir}/${modulename}.te"],
    }
  }

  # $ semodule_package -m module.mod -o module.pp
  exec { "semodule ${modulename}":
    command => "semodule_package -m ${basedir}/${modulename}.mod -o ${basedir}/${modulename}.pp"
    creates => "${basedir}/${modulename}.pp",
    require => Exec["checkmodule ${modulename}"],
  }

  case $ensure
  {
    'installed':
    {
      # $ semodule -i module.pp
      exec { "semodule install ${modulename}":
        command    => "semodule -i ${basedir}/${modulename}.pp",
        notifyonly => true,
        subscribe  => Exec["semodule ${modulename}"],
      }
    }
    default: { fail('not implemented') }
  }
}