cdb-public-vagrant
=====================

get started
-------------
I've removed the submodule process and made it more brute force on purpose.
the setup.sh will prompt you for your Rackspace account information:
* Username
* API Key
* Tenant ID (also called Cloud Account Number on the API Access page)

> $ ./setup.sh
> 
> ... enter your stuff... 
>
> $ vagrant up --provider=rackspace 
>
> profit


what this does:
----------------
* vagrant boots a rackspace cloud VM instance 
* runs bootstrap.sh 
 * jumps into vagrant environment and does some intial setup/teardown of things that may still be running
 * installs python development stuff (move to image asap) 
 * pushd /vagrant/public/reddwarf-integration/scripts/; 
 * ./redstack install 
 * ./redstack kick-start mysql
 * sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
* profits
