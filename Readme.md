# Local ISPConfig3 test env

Warning: Pet project ahead...

Vagrant environment to test ISPConfig3.

Currently installs only web, ftp & db parts. Others will follow.

ISPConfig3 has to be installed manually though.

## Prerequisites

* Ruby 1.8.7 or 1.9.x
* VirtualBox (for Vagrant)
* Git

## Install

	$ gem install bundler
	$ bundle install
	$ librarian-puppet install
	$ vagrant up
