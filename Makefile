# Define macros
SHELL := /bin/bash

default:

	if [  -f ~/.bash_profile ]
	then
		echo "bash_profile already exists"
	else
		curl -L http://github.com/squince/macdevstation/blob/master/bash_profile > ~/.bash_profile
		echo "created baseline bash_profile"
	fi

	# Install RVM
	curl -L https://get.rvm.io | bash -s stable

	# Install Homebrew
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	brew doctor
	brew install libksba
	brew install cmake autoconf automake apple-gcc42
	brew install git
	brew install python --framework
	brew install mongodb
	brew install mysql
	brew install macvim

	# RVM Install 1.9.3 and set as default
	rvm install 1.9.3
	rvm use 1.9.3 --default
	rvm pkg install libyaml; rvm pkg install readline

	# Gem installs
	gem install rake
	gem install bundler
	gem install chef --no-ri --no-rdoc
	gem install knife-block
	gem install git-pairing
	gem install promptula; promptula --install
	gem install buildr
	gem install gemcutter

	# Install Janus - VIM extensions
	curl -Lo- https://bit.ly/janus-bootstrap | bash

	# Install Python stuff
	easy_install pip
	pip install virtualenv	
