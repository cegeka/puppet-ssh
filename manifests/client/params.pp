class ssh::client::params {

  case $facts['os']['name'] {
    'RedHat','CentOS': {
      $ssh_package = 'openssh-server'
    }
    default: { fail("Unsupported operatingsystem ${facts['os']['name']}") }
  }

}

