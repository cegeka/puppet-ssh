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

  case $::operatingsystem {
    'RedHat','CentOS': { include ssh::server::redhat}
    default: { fail("Unsupported operatingsystem ${::operatingsystem}") }
  }

}
