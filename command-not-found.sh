# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# Based on PackageKit's PackageKit.sh
# Copyright (C) 2008 Richard Hughes <richard@hughsie.com>

command_not_found_handle () {
	local runcnf=1
	local retval=127
	local cnf='/usr/bin/command-not-found'

	# only search for the command if we're interactive
	[[ $- == *"i"* ]] || runcnf=0

	# don't run if bash command completion is being run
	[[ -n ${COMP_CWORD-} ]] && runcnf=0

	# don't run if we've been uninstalled since the shell was launched
	[[ ! -x ${cnf} ]] && runcnf=0

	# run the command, or just print a warning
	if [[ ${runcnf} -eq 1 ]]; then
		"${cnf}" "${@}"
		retval=${?}
	elif [[ -n "${BASH_VERSION-}" ]]; then
		printf >&2 'bash: %s%s\n' "${1:+${1}: }" 'command not found'
	elif [[ -n "${ZSH_VERSION-}" ]]; then
		printf >&2 'zsh: %s%s\n' 'command not found: ' "${1}"
	fi

	# return success or failure
	return ${retval}
}

if [[ -n "${ZSH_VERSION-}" ]]; then
	command_not_found_handler () {
		command_not_found_handle "$@"
	}
fi
