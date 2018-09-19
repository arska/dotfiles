#!/usr/bin/env bash

# Install command-line tools using MacPorts

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo port selfupdate
sudo port upgrade outdated

sudo port -N install coreutils moreutils findutils bash bash-completion git-flow-bash-completion wget screen pwgen tcpdump aircrack-ng binutils binwalk dns2tcp fcrackzip nmap socat tcptrace mtr git git-lfs python35 python27 mplayer ipcalc ipv6calc pv mtr py27-readline py35-readline python36 py36-readline

sudo port select --set python python36
sudo port select --set python3 python36
sudo port select --set python2 python27

sudo port install vim +huge +python36 +python27

sudo -H pip install virtualenv

if [ "0" -eq  "$(fgrep -c /opt/local/bin/bash /etc/shells)" ] ; then
  sudo bash -c "(echo /opt/local/bin/bash >> /etc/shells)"
fi

chsh -s /opt/local/bin/bash

# update OpenShift client oc and bash completion
wget -O ~/bin/oc https://console.appuio.ch/console/extensions/clients/macosx/oc
chmod +x ~/bin/oc
~/bin/oc completion bash > ~/bin/oc.bashcompletion

