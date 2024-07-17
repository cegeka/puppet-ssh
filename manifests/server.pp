# Class: ssh
#
# This module manages ssh
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh::server (
  $ensure = present,
){

  case $facts['os']['name'] {
    'RedHat','CentOS','OracleLinux': { include ssh::server::redhat}
    default: { fail("Unsupported operatingsystem $facts['os']['name']") }
  }

}
