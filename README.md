# A command-not-found handler for Gentoo systems

This repository contains a simple shell script that defines `command_not_found_handle` (for bash) and `command_not_found_handler` (for zsh). Whenever possible it will call the `command-not-found` python script which will:

- call `snap advise-snap --command ...` if `app-containers/snapd` is installed
- suggest commands that do exist and closely match the non-existing command
- search the [Portage File List](https://www.portagefilelist.de/) for packages that install the non-existing command if `app-portage/pfl` is installed

To install it simply `emerge app-portage/command-not-found`, and optionally install `app-containers/snapd` and/or `app-portage/pfl` as well.
