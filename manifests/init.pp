# Module:: metche
# Manifest:: init.pp
#
# Author:: Sebastien Badia (<seb@sebian.fr>)
# Date:: Thu May 17 20:56:45 +0200 2012
# Maintainer:: Sebastien Badia (<seb@sebian.fr>)
#

# === Parameters
# [metche_changelog] Activate single changelog file monitoring (/root/Changelog)
# [metche_dopkg] Debian packages monitoring (yes)
# [metche_watchdir] Directory watched by metche (/etc)
# [metche_dodetail] Show diff details for modified files (no)
# [metche_test_time] Minutes until unstable goes to testing (120 min)
# [metche_stable_time] Days until testing goes to stable (3 days)
# [metche_email] Address receiving testing changes report (root)
# [metche_send_stable] Email $EMAIL_ADDRESS after saving a stable state (yes)
# [metche_excludes] Excludes files from metche reports (*.swp)

# Class metche
#
#
class metche(
    $metche_changelog   = '/root/Changelog',
    $metche_owner       = 'root',
    $metche_dopkg       = 'yes',
    $metche_watchdir    = '/etc',
    $metche_dodetail    = 'no',
    $metche_test_time   = '60',
    $metche_stable_time = '3',
    $metche_email       = 'root@localhost',
    $metche_send_stable = 'no',
    $metche_excludes    = '*.swp *.git') {

  package {
    'metche':
      ensure  => installed,
      require => [File['/etc/metche.conf'],File[$metche_changelog]];
  }

  if $metche_dopkg == 'yes' {
    package {
      'apt-show-versions':
        ensure => installed;
    }
  }

  file {
    '/etc/metche.conf':
      ensure  => file,
      content => template('metche/metche.conf.erb'),
      owner   => $metche_owner,
      group   => $metche_owner,
      mode    => '0644';
    $metche_changelog:
      ensure  => file,
      content => template('metche/changelog.init.erb'),
      replace => false,
      owner   => $metche_owner,
      group   => $metche_owner,
      mode    => '0644';
  }
} # Class metche
