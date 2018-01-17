class ssh::client::params {

  case $::operatingsystem {
    'RedHat','CentOS': {
      $ssh_package = 'openssh-server'
    }
    default: { fail("Unsupported operatingsystem ${::operatingsystem}") }
  }

}

