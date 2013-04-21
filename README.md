# puppet-metche
https://labs.riseup.net/code/projects/metche

Manage [metche](https://labs.riseup.net/code/projects/metche) via Puppet

## Usage

### Using default values
```
include 'metche'
```

### Overide values
```
  class {
    'metche':
      metche_dopkg    => true,
      metche_dodetail => true,
      metche_email    => 'notifs@foobar.org',
  }
```

## Other class parameters

# === Parameters
* metche\_changelog: Activate single changelog file monitoring (/root/Changelog)
* metche\_dopkg: Debian packages monitoring (yes)
* metche\_watchdir: Directory watched by metche (/etc)
* metche\_dodetail: Show diff details for modified files (no)
* metche\_test\_time: Minutes until unstable goes to testing (120 min)
* metche\_stable\_time: Days until testing goes to stable (3 days)
* metche\_email: Address receiving testing changes report (root)
* metche\_send\_stable: Email $EMAIL\_ADDRESS after saving a stable state (yes)
* metche\_excludes: Excludes files from metche reports (\*.swp)
