# Define macros
SHELL := /bin/bash
BREW_TEST := Example usage
BREW_TAP = versions
FILE_TEST := No such file

# ***** Brew Installed? *****
ifneq (,$(findstring $(BREW_TEST),$(shell brew help)))
	DO_BREW = pushd /usr/local/Library; git stash; git clean -df; popd; brew update
else
	DO_BREW = ruby -e $(curl -fsSL https://raw.github.com/mxcl/homebrew/go)
endif


# ***** Bash Profile Exist? *****
ifneq (,$(findstring $(FILE_TEST),$(shell ls ~/.bash_profile)))
	DO_BASH_PROFILE = echo bash_profile already exists
else
	DO_BASH_PROFILE = curl -fsSL https://raw.github.com/squince/macdevastation/master/bash_profile > ~/.bash_profile && source ~/.bash_profile
endif


# ***** MacVim Installed? *****
ifneq (,$(findstring $(FILE_TEST),$(shell ls /Applications/MacVim.app)))
	DO_MACVIM = echo MacVim already installed
else
	DO_MACVIM = brew install macvim
endif


# ***** Brew Versions Tapped? *****
ifeq (,$(findstring $(BREW_TAP),$(shell brew tap)))
	DO_BREW_TAP = brew tap homebrew/versions
else
	DO_BREW_TAP = echo Already Brew Tapped Versions
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

all: baseline ruby cli python databases node
	#
	# Executes all targets

baseline:
	#
	# Install Homebrew
	
	$(DO_BREW)	
	brew doctor
	-brew install git

cli: 
	#ruby
	#	
	# Install Command Line Tools

	$(DO_BASH_PROFILE)
	$(DO_MACVIM)	
	# Install Janus - VIM extensions
	-curl -Lo- https://bit.ly/janus-bootstrap | bash

	-gem install git-pairing
	-gem install promptula
	-promptula --install

ruby: baseline
	#
	# Install Ruby and related tools

	curl -L https://get.rvm.io | bash -s stable

	$(DO_BREW_TAP)
	#brew install gcc48
	chmod go+w /usr/local/lib
	chmod go+w /usr/local/share
	-brew install libksba
	-brew install cmake
	rvm autolibs enable
	rvm install 1.9.3
	rvm use 1.9.3 --default

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

	-brew install mongodb
	-brew install mysql

node: baseline
	#
	# Install node and npm packages

	brew install node
	npm install grunt-cli -g
