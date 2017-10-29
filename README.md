# puppeteer
Template vagrant VM that installs puppet server from the puppet collections repo.

## Pre-requisites
This VM was built using:
- Vagrant 1.9.3
- Virtual 5.1.20 r114629 (Qt5.6.2)

## Usage

If you have puppet server code already in a git repository, drop it into the puppeteer directory. The puppeteer directory is just a placeholder. For example:
	
	> git clone https://github.com/templesofcode/puppeteer.git vagrant_puppeteer
	> cd vagrant_puppeteer
	> rm -rf puppeteer
	> git clone <PUPPETSERVER_REPO> puppeteer
	> cd puppeteer
	> ls 
	environments	modules ...
	...
	
	
Invoke vagrant up with the required parameters. 

	vagrant --hostname=<HOSTNAME> --ip=<IP> up

For example:

	vagrant --hostname='puppetserver.mystuff.com' --ip='192.168.33.11' up

Then, to destroy:

	vagrant --hostname='puppetserver.mystuff.com' --ip='192.168.33.11' destroy
