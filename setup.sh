#!/bin/bash

if [ -d public ]; then
  rm -rf public/
else
  mkdir public
fi

pushd public 
VAGRANT=$(which vagrant)
if [ -z $VAGRANT ]; then
  echo "Please install vagrant:  http://docs.vagrantup.com/v2/installation/index.html" 
  exit 127
fi
# clone public  codebase

git clone git@github.com:stackforge/python-reddwarfclient.git
git clone git@github.com:stackforge/reddwarf-integration.git
git clone git@github.com:stackforge/reddwarf.git

popd
if [ ! $(vagrant plugin list  | grep vagrant-rackspace > /dev/null) ]; then
  vagrant plugin install vagrant-rackspace
fi

echo "Run 'vagrant up --provider=rackspace'"
