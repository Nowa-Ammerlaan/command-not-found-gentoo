# A command-not-found handler for Gentoo systems

This repository contains a simple shell script that defines `command_not_found_handle` (for bash) and `command_not_found_handler` (for zsh). Whenever possible it will call the `command-not-found` python script which will:

- call `snap advise-snap --command ...` if `app-containers/snapd` is installed
- suggest commands that do exist and closely match the non-existing command
- search the [Portage File List](https://www.portagefilelist.de/) for packages that install the non-existing command if `app-portage/pfl` is installed

To install it simply `emerge app-portage/command-not-found`, and optionally install `app-containers/snapd` and/or `app-portage/pfl` as well.

## Example output:

A typo on the command line:
```
andrew@andrew-gentoo-laptop ~ $ szh

Command "szh" not found


Maybe you meant one of these commands:
- sh
- zsh
- ssh


Searching the Portage File List for packages installing szh...

No candidates found

```

Trying to execute a command that is not installed, but is available in portage:
```
andrew@andrew-gentoo-laptop ~ $ radeontop

Command "radeontop" not found


Searching the Portage File List for packages installing radeontop...

*  app-misc/radeontop
Seen Versions:          1.4 9999
Portage Versions:       1.3-r3 1.4 9999
Repository:             gentoo
Homepage:               https://github.com/clbr/radeontop
Description:            Utility to view Radeon GPU utilization
Matched Files:          /usr/bin/radeontop

*  app-misc/radeontop
Seen Versions:          1.3-r3
Portage Versions:       1.3-r3 1.4 9999
Repository:             gentoo
Homepage:               https://github.com/clbr/radeontop
Description:            Utility to view Radeon GPU utilization
Matched Files:          /usr/sbin/radeontop

```

Trying to execute a command that is not installed, but is available both in portage and as a snap:
```
andrew@andrew-gentoo-laptop ~ $ audacity

Command "audacity" not found, but can be installed with:

sudo snap install audacity

See 'snap info <snap name>' for additional versions.


Searching the Portage File List for packages installing audacity...

*  media-sound/audacity
Seen Versions:          3.2.5-r1 3.3.3
Portage Versions:       2.4.2-r3 3.2.5-r1 3.3.3 9999
Repository:             gentoo
Homepage:               https://www.audacityteam.org/
Description:            Free crossplatform audio editor
Matched Files:          /usr/bin/audacity

```
