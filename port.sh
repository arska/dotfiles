#!/usr/bin/env bash

# Install command-line tools using MacPorts

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo port selfupdate
sudo port upgrade outdated

sudo port -N install coreutils moreutils findutils bash bash-completion git-flow-bash-completion wget screen pwgen tcpdump aircrack-ng parallel binwalk dns2tcp fcrackzip nmap socat tcptrace mtr git git-lfs python35 python27 mplayer ipcalc ipv6calc pv mtr py27-gnureadline py35-gnureadline py27-pip py35-pip python36 py36-gnureadline py36-pip inetutils python34 py34-pip py34-gnureadline mosh python37 py37-pip py37-gnureadline

sudo port select --set python python36
sudo port select --set python3 python36
sudo port select --set python2 python27
sudo port select --set pip pip36

sudo port install vim +huge +python36 +python27

sudo -H pip install virtualenv black pip-tools

if [ "0" -eq  "$(fgrep -c /opt/local/bin/bash /etc/shells)" ] ; then
  sudo bash -c "(echo /opt/local/bin/bash >> /etc/shells)"
fi

chsh -s /opt/local/bin/bash

# update OpenShift client oc and bash completion

if [[ -f ~/bin/oc && $(oc version | head -n 1) -eq "oc v3.9.0+191fece" ]] ; then
  echo oc already installed
else
  # update OpenShift client oc and bash completion
wget -O ~/bin/oc.zip https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-mac.zip
  cd ~/bin/
  unzip ~/bin/oc.zip
  chmod +x ~/bin/oc
  ~/bin/oc completion bash > ~/bin/oc.bashcompletion
fi
