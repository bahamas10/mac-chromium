mac-chromium
============

Install and upgrade chromium on OS X.

Usage
=====

Run the script from the command line to download and install the latest Chromium.

Examples
========

#### Download and install the newest chromium for mac

    ~$ mac-chromium.sh

#### Check for an update, exit 0 if up-to-date, 1 if there's an update, 2 if error

    ~$ mac-chromium.sh -cq

#### Download and install the newest chromium with no output

    ~$ mac-chromium.sh -q

Options
=======

    -h : print this message and exit
    -c : check only, don't upgrade
    -f : force an update even if chromium is running
    -q : suppress output, just use exit codes

Copying
=======

Released under the BSD 3-clause license, see LICENSE for details.
