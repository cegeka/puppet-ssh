class ssh::server::params {

  case $::operatingsystem {
    'RedHat','CentOS','OracleLinux': {
      $sshd_package = 'openssh-server'
      $sshd_service = 'sshd'
      $sshd_config = '/etc/ssh/sshd_config'
    }
    default: { fail("Unsupported operatingsystem ${::operatingsystem}") }
  }

}
