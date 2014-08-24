# Puppet-metche

[![Build Status](https://travis-ci.org/sbadia/puppet-metche.png?branch=master)](https://travis-ci.org/sbadia/puppet-metche)
[![Puppet Forge](http://img.shields.io/puppetforge/v/sbadia/metche.svg)](https://forge.puppetlabs.com/sbadia/metche)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)



Manage [metche](https://labs.riseup.net/code/projects/metche) via Puppet

## Overview

Metche is a system that monitors \*nix servers configuration file for easy change tracking and team coordination.

Its most helpful feature is the automatic sending of change reports
(changelog + packages + configuration diff)

## Usage

### Using default values

```puppet
include 'metche'
```

### Override values

```puppet
class { 'metche':
  dopkg    => true,
  dodetail => true,
  email    => 'notifs@foobar.org',
}
```


## Other class parameters

* `changelog`: Activate single changelog file monitoring (/root/Changelog)
* `dopkg`: Debian packages monitoring (yes)
* `watchdir`: Directory watched by metche (/etc)
* `dodetail`: Show diff details for modified files (no)
* `test_time`: Minutes until unstable goes to testing (120 min)
* `stable_time`: Days until testing goes to stable (3 days)
* `email`: Address receiving testing changes report (root)
* `send_stable`: Email $EMAIL\_ADDRESS after saving a stable state (yes)
* `excludes`: Excludes files from metche reports (\*.swp)

# Contributors

* https://github.com/sbadia/puppet-metche/graphs/contributors

# Release Notes

See [CHANGELOG](https://github.com/sbadia/puppet-metche/blob/master/CHANGELOG.md) file.

## Development

[Feel free to contribute](https://github.com/sbadia/puppet-metche/). I'm not a big fan of centralized services like GitHub but I used it to permit easy pull-requests, so show me that's a good idea!
