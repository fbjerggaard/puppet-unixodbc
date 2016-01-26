# == Class: unixodbc
#
# Full description of class unixodbc here.
#
# === Parameters
#
# [*package_name*]
#   Defines the package name to be installed. Defaults to 'unixodbc'
#
# [*package_ensure*]
#   Sets the ensure status on the package. Defaults to 'present'
#
# [*config_path*]
#   Sets the path for the configuration files. Defaults to '/etc/'
#
# === Authors
#
# Frederik Bjerggaard Nielsen <fbn@firstcom.dk>
#
# === Copyright
#
# Copyright 2016 Firstcom A/S
#
class unixodbc (
  $package_name   = $::unixodbc::params::package_name,
  $package_ensure = $::unixodbc::params::package_ensure,
  $config_path    = $::unixodbc::params::config_path,
  ) inherits unixodbc::params {
  class { '::unixodbc::package':
    package_name   => $package_name,
    package_ensure => $package_ensure
  }

}
