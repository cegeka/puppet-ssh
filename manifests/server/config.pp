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
define ssh::server::config (
  $ensure = present,
  $sshd_parameter = undef,
  $sshd_value = undef
){

  include ssh::server::params

  augeas { "sshd_config_${sshd_parameter}":
    incl    => $::ssh::server::params::sshd_config,
    lens    => 'Sshd.lns',
    context => "/files${::ssh::server::params::sshd_config}",
    changes => [
      "set ${sshd_parameter} ${sshd_value}"
    ],
    require => Package[$::ssh::server::params::sshd_package],
    notify  => Service[$::ssh::server::params::sshd_service]
  }

}
