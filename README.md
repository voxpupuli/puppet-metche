# puppet-metche

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
      dopkg    => true,
      dodetail => true,
      email    => 'notifs@foobar.org',
  }
```

## Other class parameters

* changelog: Activate single changelog file monitoring (/root/Changelog)
* dopkg: Debian packages monitoring (yes)
* watchdir: Directory watched by metche (/etc)
* dodetail: Show diff details for modified files (no)
* test\_time: Minutes until unstable goes to testing (120 min)
* stable\_time: Days until testing goes to stable (3 days)
* email: Address receiving testing changes report (root)
* send\_stable: Email $EMAIL\_ADDRESS after saving a stable state (yes)
* excludes: Excludes files from metche reports (\*.swp)
