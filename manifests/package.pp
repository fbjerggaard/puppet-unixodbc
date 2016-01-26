# == Class: unixodbc::package
#
# Installs the unixodbc package
#
# === Parameters
#
# [*package_name*]
#   Defines the package name to be installed. Defaults to 'unixodbc'
#
# [*package_ensure]
#   Sets the ensure status on the package. Defaults to 'present'
#
# === Authors
#
# Frederik Bjerggaard Nielsen <fbn@firstcom.dk>
#
# === Copyright
#
# Copyright 2016 Firstcom A/S
class unixodbc::package(
  $package_name   = $::unixodbc::package_name,
  $package_ensure = $::unixodbc::package_ensure,
  ) {
  case $::osfamily {
    'debian': {
      package { 'unixodbc':
        ensure => $package_ensure,
        name   => $package_name
      }
    }
    default: {
      fail("Module ${module_name} has no config for ${::osfamily}")
    }
  }
}
