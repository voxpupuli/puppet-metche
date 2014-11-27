# == Class: metche
#
# Install and configure metche
#
# === Parameters
#
# [*changelog*]
#   Activate single changelog file monitoring.
#   Default: /root/Changelog
#
# [*owner*]
#   Owner and group of the Changelog file.
#   Default: root
#
# [*dopkg*]
#   Enable debian packages monitoring (this value is directly added
#   in metche configuration. Values are: [yes|no]
#   Default: yes
#
# [*watchdir*]
#   Directory watched by metche
#   Default: /etc)
#
# [*dodetail*]
#   Show diff details for modified files in metche email
#   Warning, please enable crypted mails
#   Default: no
#
# [*test_time*]
#   Minutes until unstable goes to testing
#   Default: 120
#
# [*stable_time*]
#   Days until testing goes to stable
#   Default: 3
#
# [*email*]
#   Address receiving testing changes report
#   Default: root
#
# [*send_stable*]
#   Send a email to $EMAIL_ADDRESS after saving a stable state
#   Default: yes
#
# [*excludes*]
#   Excludes files from metche reports
#   Default: *.swp
#
# === Examples
#
#  class {
#    'metche':
#      dopkg    => true,
#      dodetail => true,
#      email    => 'notifs@foobar.org',
#  }
#
# === Authors
#
# Sebastien Badia <http://sebastien.badia.fr/>
#
# === Copyright
#
# Copyleft 2013 Sebastien Badia
# See LICENSE file
#
class metche(
  $changelog   = '/root/Changelog',
  $owner       = 'root',
  $dopkg       = 'yes',
  $watchdir    = '/etc',
  $dodetail    = 'no',
  $test_time   = '60',
  $stable_time = '3',
  $email       = 'root@localhost',
  $send_stable = 'no',
  $excludes    = '*.swp *.git'
  ) {

  package {
    'metche':
      ensure  => installed,
      require => [File['/etc/metche.conf'],File[$changelog]];
  }

  if $dopkg == 'yes' {
    package {
      'apt-show-versions':
        ensure => installed;
    }
  }

  file {
    '/etc/metche.conf':
      ensure  => file,
      content => template('metche/metche.conf.erb'),
      owner   => $owner,
      group   => $owner,
      mode    => '0644';
    $changelog:
      ensure  => file,
      content => template('metche/changelog.init.erb'),
      replace => false,
      owner   => $owner,
      group   => $owner,
      mode    => '0644';
  }
} # Class metche
