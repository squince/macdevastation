# Define macros
SHELL := /bin/bash
BREW_TEST := Example usage
RVM_TEST := RVM is the Ruby enVironment Manager (rvm)
BREW_TAP = versions
FILE_TEST := No such file
RUBY_TEST := ruby-1.9.3

# ***** Brew Installed? *****
ifneq (,$(findstring $(BREW_TEST),$(shell brew help)))
	DO_BREW = pushd /usr/local/Library; git stash; git clean -df; popd; brew update
else
	DO_BREW = ruby -e $(curl -fsSL https://raw.github.com/mxcl/homebrew/go)
endif

# ***** RVM Installed? *****
ifneq (,$(findstring $(RVM_TEST),$(shell rvm help)))
	DO_RVM = rvm get stable
else
	DO_RVM = curl -L get.rvm.io | bash -s stable
endif

# ***** Ruby 1.9.3 Installed? *****
ifneq (,$(findstring $(RUBY_TEST),$(shell rvm list)))
	DO_RUBY = rvm use 1.9.3 --default
else
	DO_RUBY = rvm install 1.9.3; rvm use 1.9.3 --default
endif

# ***** Bash Profile Exist? *****
ifneq (,$(findstring $(FILE_TEST),$(shell ls ~/.bash_profile)))
	DO_BASH_PROFILE = echo bash_profile already exists
else
	DO_BASH_PROFILE = curl -fsSL https://raw.github.com/squince/macdevastation/master/bash_profile > ~/.bash_profile; chmod go+r+w ~/.bash_profile
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

cli: ruby
	#	
	# Install Command Line Tools

	-gem install git-pairing --no-ri --no-rdoc
	-gem install promptula --no-ri --no-rdoc
	$(DO_BASH_PROFILE)
	$(DO_MACVIM)	
	# Install Janus - VIM extensions
	-curl -Lo- https://bit.ly/janus-bootstrap | bash
	-curl -Lo- https://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip > ./iTerm2.zip; unzip -uq ./iTerm2.zip -d /Application


ruby: baseline
	#
	# Install Ruby and related tools

	$(DO_RVM)
	$(DO_RUBY)
	$(DO_BREW_TAP)
	#brew install gcc48
	chmod go+w /usr/local/lib
	chmod go+w /usr/local/share
	-brew install libksba
	-brew install cmake
	rvm autolibs enable

	# Gem installs
	gem update --system
	gem install rake --no-ri --no-rdoc
	gem install bundler --no-ri --no-rdoc
	gem install chef --no-ri --no-rdoc
	gem install knife-block --no-ri --no-rdoc
	gem install buildr --no-ri --no-rdoc
	gem install gemcutter --no-ri --no-rdoc

python: baseline
	#
	# Install Python and related tools

	#brew link --overwrite python
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

	-brew install node
	-npm install grunt-cli -g
