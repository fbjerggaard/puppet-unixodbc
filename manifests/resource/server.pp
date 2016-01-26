# define: unixodbc::resource::server
#
# This definition defines a server connection
#
# Parameters:
# [*ensure*]
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#
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
  $config_file = '/etc/odbc.ini'
  concat { $config_file:
    owner => 'root',
    group => 'root',
    mode  => '644',
  }
  concat::fragment { "server-${name}":
    ensure  => $ensure,
    target  => $config_file,
    content => template('unixodbc/server.erb'),
    order   => '001',
  }
}
