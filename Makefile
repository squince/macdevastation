# TODO: Conditionalize each target (or portion thereof) so that installs only run for
# 			items not already installed and configured - this Makefile is a onetime initialization
# 			of a developer workstation

# Define macros
SHELL := /bin/bash

default:
	#
	# The following targets are available:
	
	#	 - databases
	#	 - python
	#	 - ruby
	#	 - cli

baseline:
	#
	# Install Homebrew
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	brew doctor
	brew install git

cli: ruby
	#	
	# Install Command Line Tools

	ifeq ($(wildcard ~/.bash_profile),)
		echo "bash_profile already exists"
	else
		curl -L http://github.com/squince/macdevstation/blob/master/bash_profile > ~/.bash_profile
		echo "created baseline bash_profile"
	endif	
	brew install macvim
	# Install Janus - VIM extensions
	curl -Lo- https://bit.ly/janus-bootstrap | bash

	gem install git-pairing
	gem install promptula; promptula --install

ruby: baseline
	#
	# Install Ruby and related tools

	curl -L https://get.rvm.io | bash -s stable

	brew install libksba
	brew install cmake autoconf automake apple-gcc42
	rvm install 1.9.3
	rvm use 1.9.3 --default
	rvm pkg install libyaml; rvm pkg install readline

	#
	# Gem installs
	gem install rake
	gem install bundler
	gem install chef --no-ri --no-rdoc
	gem install knife-block
	gem install buildr
	gem install gemcutter

python: baseline
	#
	# Install Python and related tools

	brew install python --framework
	easy_install pip
	pip install virtualenv	

databases: baseline
	#
	# Install MongoDB and MySQL
	
	brew install mongodb
	brew install mysql

