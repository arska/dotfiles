#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo port selfupdate
sudo port upgrade outdated

sudo port install coreutils moreutils findutils bash bash-completion git-flow-bash-completion wget screen pwgen tcpdump aircrack-ng binutils binwalk dns2tcp fcrackzip nmap socat tcptrace mtr git git-lfs python35 python27 mplayer ipcalc ipv6calc pv

sudo port select --set python python35
sudo port select --set python3 python35
sudo port select --set python2 python27

sudo port install vim +huge +python35 +python27
