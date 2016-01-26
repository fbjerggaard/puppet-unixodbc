# == Define: unixodbc::resource::driver
#
# This defines a unixodbc driver
#
# Parameters:
# [*ensure*]
#
# [*description*]
#
# [*driver*]
#
# [*setup*]
#
# [*driver64*]
#
# [*setup64*]
#
# [*fileUsage*]
#
# Sample Usage:
#  unixodbc::resource::driver { 'PostgreSQL':
#    ensure      => 'present',
#    description => 'ODBC for PostgreSQL',
#    driver      => '/usr/lib/psqlodbc.so',
#    setup       => '/usr/lib/libodbcpsqlS.so',
#    driver64    => '/usr/lib64/psqlodbc.so',
#    setup64     => '/usr/lib64/libodbcpsqlS.so',
#    fileUsage   => 1,
#  }
#
# === Authors
#
# Frederik Bjerggaard Nielsen <fbn@firstcom.dk>
#
# === Copyright
#
# Copyright 2016 Firstcom A/S
define unixodbc::resource::driver (
  $ensure = 'present',
  $description = undef,
  $driver = undef,
  $setup = undef,
  $driver64 = undef,
  $setup64 = undef,
  $fileUsage = undef,
  ) {
    if ! ($ensure in [ 'present', 'absent' ]) {
      fail("${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
    }
    if ($description != undef) {
      validate_string($description)
    } else {
      fail('$description must be set')
    }
    if ($driver != undef) {
      validate_absolute_path($driver)
    } else {
      fail('$driver must be set')
    }
    if ($setup != undef) {
      validate_absolute_path($setup)
    } else {
      fail('$setup must be set')
    }
    if ($driver64 != undef) {
      validate_absolute_path($driver64)
    }
    if ($setup64 != undef) {
      validate_absolute_path($setup64)
    }
    if ($fileUsage != undef) {
      validate_integer($fileUsage)
    } else {
      fail('$fileUsage must be set')
    }
    $config_file = '/etc/odbcinst.ini'
    concat { $config_file:
      owner => 'root',
      group => 'root',
      mode  => '644',
    }
    concat::fragment { "driver-${name}":
      ensure  => $ensure,
      target  => $config_file,
      content => template('unixodbc/driver.erb'),
      order   => '001',
    }
  }
