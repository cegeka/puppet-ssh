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

  if ($ensure == 'present') { $action = 'set' } else { $action = 'rm' }

  # https://augeas.net/docs/references/1.4.0/lenses/files/sshd-aug.html#Sshd.CAVEATS
  # Insert an sshd_config parameter before the Match parameter,
  #   this will only run if the parameter doesn't already exist
  # In some edge-cases you need the clean sshd parameter, example: MACs for MACs/1 or Ciphers for Ciphers/1
  $sshd_parameter_clean = $sshd_parameter.split('/')[0]

  if ($ensure == 'present' and $sshd_parameter_clean != 'Match') {
    augeas { "sshd_config_insert_${sshd_parameter}":
      incl    => $::ssh::server::params::sshd_config,
      context => "/files${::ssh::server::params::sshd_config}",
      lens    => 'Sshd.lns',
      changes => [
        "insert ${sshd_parameter_clean} after Subsystem",
        "${action} ${sshd_parameter} '${sshd_value}'"
      ],
      onlyif  => "match /files${::ssh::server::params::sshd_config}/${sshd_parameter_clean} size == 0",
      require => Package[$::ssh::server::params::sshd_package],
      notify  => Service[$::ssh::server::params::sshd_service]
    }
  }

  augeas { "sshd_config_${sshd_parameter}":
    incl    => $::ssh::server::params::sshd_config,
    lens    => 'Sshd.lns',
    context => "/files${::ssh::server::params::sshd_config}",
    changes => [
      "${action} ${sshd_parameter} '${sshd_value}'"
    ],
    require => [
      Package[$::ssh::server::params::sshd_package],
      ($ensure == 'present' and $sshd_parameter_clean != 'Match') ? { true => Augeas["sshd_config_insert_${sshd_parameter}"], default => undef }
    ],
    notify  => Service[$::ssh::server::params::sshd_service]
  }

}
