mac-chromium
============

Install and upgrade chromium on OS X.

![Chromium][0]

Usage
-----

Run the script from the command line to download and install the latest Chromium

Examples
--------

Check to see if there is a newer version of Chromium available

    $ ./mac-chromium.sh -c
    Chromium is out-of-date!
    Current Version :: 146768
    Latest Version  :: 148329

Download and install the newest chromium for mac

    ~$ mac-chromium.sh
    Chromium is out-of-date!
    Current Version :: 146768
    Latest Version  :: 148329
    Downloading the latest chromium...
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 38.3M  100 38.3M    0     0  1432k      0  0:00:27  0:00:27 --:--:-- 3013k
    Installed Chromium 148329

Check for an update, exit 0 if up-to-date, 1 if there's an update, 2 if error

    ~$ mac-chromium.sh -cq

Download and install the newest chromium with no output

    ~$ mac-chromium.sh -q

Options
-------

    -h : print this message and exit
    -c : check only, don't upgrade
    -f : force an update even if chromium is running
    -q : suppress output, just use exit codes



Copying
-------

Released under the BSD 3-clause license, see LICENSE for details.

[0]: http://www.daveeddy.com/static/media/2012/07/25/Google-Chrome-Chromium-icon.png
