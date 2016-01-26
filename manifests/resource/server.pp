# == Define: unixodbc::resource::server
#
# This definition defines a server connection
#
# === Parameters:
# [*ensure*]
#
# [*host*]
#
# [*driver*]
#
# [*database*]
#
# [*port*]
#
# === Sample Usage:
#
#  unixodbc::resource::server { '192.168.1.1':
#    ensure   => 'present',
#    driver   => 'PostgreSQL',
#    database => 'myawesomestuff',
#    port     => 5432,
#  }
#
# === Authors
#
# Frederik Bjerggaard Nielsen <fbn@firstcom.dk>
#
# === Copyright
#
# Copyright 2016 Firstcom A/S
define unixodbc::resource::server (
  $ensure = 'present',
  $host = $name,
  $driver = undef,
  $database = undef,
  $port = undef,
  ) {
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  }
  if ($host != undef) {
    validate_string($host)
  } else {
    fail('$host must be set')
  }
  if ($driver != undef) {
    validate_string($driver)
  } else {
    fail('$driver must be set')
  }
  if ($database != undef) {
    validate_string($database)
  } else {
    fail('$host must be set')
  }
  if !is_integer($port) {
    fail('$port must be an integer.')
  }
  $config_file = "${unixodbc::config_path}/odbc.ini"
  ensure_resource('concat', $config_file, {
    owner          => 'root',
    group          => 'root',
    mode           => '644',
    ensure_newline => true,
  })
  concat::fragment { "server-${name}":
    ensure  => $ensure,
    target  => $config_file,
    content => template('unixodbc/server.erb'),
    order   => '001',
  }
}
