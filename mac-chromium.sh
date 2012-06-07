#!/usr/bin/env  bash
#
# Easily install and update chromium for mac
#
# Author: Dave Eddy <dave@daveeddy.com>

# The chromium build URL
chromium_url='http://commondatastorage.googleapis.com/chromium-browser-continuous/Mac'

# Print usage
usage() {
	cat <<-EOF
	Usage: ${0##*/} [ options ]

	Install and upgrade chromium on OS X

	-h : print this message and exit
	-c : check only, don't upgrade
	-f : force an update even if chromium is running
	-q : suppress output, just use exit codes

	Examples

	Download and install the newest chromium for mac
	~$ ${0##*/}

	Check for an update, exit 0 if up-to-date, 1 if there's an update, 2 if error
	~$ ${0##*/} -cq

	Download and install the newest chromium with no output
	~$ ${0##*/} -q
	EOF
}

# Log output if ! quiet
log() {
	$quiet || echo "$@"
}

# Install Chromium by version number
install_chromium() {
	local version=$1
	local filename=/tmp/mac-chromium.$$.zip

	# Ensure Chromium isn't running
	if ps -ef | grep -q '[C]hromium.app'; then
		log 'Chromium is running!'
		$force || exit 2
	fi

	# Download the build
	log 'Downloading the latest chromium...'
	curl "$chromium_url/$version/chrome-mac.zip" -o "$filename" || exit 3
	if cd /tmp && unzip -q "$filename"; then
		rm -rf /Applications/Chromium.app
		cp -r ./chrome-mac/Chromium.app /Applications/Chromium.app
		rm -rf "$filename" ./chrome-mac
		log "Installed Chromium $version"
	else
		log 'Failed to install!'
		exit 4
	fi
}

check=false
force=false
quiet=false
# Get command line options
while getopts 'cfqh' options; do
	case "$options" in
		c) check=true;;
		f) force=true;;
		q) quiet=true;;
		h) usage >&2; exit 0;;
		*) usage >&2; exit 1;;
	esac
done

# Get the version
current_version=$(defaults read /Applications/Chromium.app/Contents/Info SVNRevision)
latest_version=$(curl -Ss "$chromium_url/LAST_CHANGE")

# Check the version
if [[ -z "$current_version" ]]; then
	log "Couldn't determine current version of Chromium."
	$check && exit 2 || install_chromium "$latest_version"
elif (( current_version < latest_version )); then
	log 'Chromium is out-of-date!'
	log "Current Version :: $current_version"
	log "Latest Version  :: $latest_version"
	$check && exit 1 || install_chromium "$latest_version"
else
	log 'Chromium is up-to-date'
	exit 0
fi
