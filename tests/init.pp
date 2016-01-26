# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
include unixodbc

unixodbc::resource::server { '192.168.1.1':
  ensure    => 'present',
  driver    => 'PostgreSQL',
  database  => 'myawesomestuff',
  fileUsage => 5432,
}

unixodbc::resource::driver { 'PostgreSQL':
  ensure      => 'present',
  description => 'ODBC for PostgreSQL',
  driver      => '/usr/lib/psqlodbc.so',
  setup       => '/usr/lib/libodbcpsqlS.so',
  driver64    => '/usr/lib64/psqlodbc.so',
  setup64     => '/usr/lib64/libodbcpsqlS.so',
  fileUsage   => 1,
}

unixodbc::resource::driver { 'FreeTDS':
  ensure      => 'present',
  description => 'ODBC for SQL Server',
  driver      => '/usr/lib64/libtdsodbc.so.0',
  setup       => '/usr/lib64/libtdsS.so',
  fileUsage   => 1,
}
