# Define macros
SHELL := /bin/bash
BREW_TEST := Example usage

ifneq (,$(findstring $(BREW_TEST),$(shell brew help)))
	DO_BREW = pushd /usr/local/Library; git stash; git clean -df; popd; brew update
else
	DO_BREW = ruby -e $(curl -fsSL https://raw.github.com/mxcl/homebrew/go)
endif

ifeq ($(wildcard ~/.bash_profile),)
	DO_BASH_PROFILE = echo bash_profile already exists
else
	DO_BASH_PROFILE = curl -L http://github.com/squince/macdevstation/blob/master/bash_profile > ~/.bash_profile
endif	

default:
	#
	# The following targets are available:
	
	#	 - all -> as implied, executes all below targets
	#	 - databases
	#	 - python
	#	 - ruby
	#	 - cli
	#	 - node

all: baseline ruby python cli databases node
	#
	# Executes all targets

baseline:
	#
	# Install Homebrew
	
	$(DO_BREW)	
	brew doctor
	brew install git

cli: ruby
	#	
	# Install Command Line Tools

	$(DO_BASH_PROFILE)
	brew install macvim
	# Install Janus - VIM extensions
	curl -Lo- https://bit.ly/janus-bootstrap | bash

	gem install git-pairing
	gem install promptula; promptula --install

ruby: baseline
	#
	# Install Ruby and related tools

	curl -L https://get.rvm.io | bash -s stable

	#brew tap homebrew/versions
	brew install gcc48
	brew install libksba
	#brew install cmake autoconf automake
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

node: baseline
	#
	# Install node and npm packages

	brew install node
	npm install grunt-cli -g
