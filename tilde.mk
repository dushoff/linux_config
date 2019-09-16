## This file is the Makefile for ~dushoff, curated in linux_config
## It should be a link, not a copy. Use `make relink` (there) to fix

PUSH = perl -wf $(filter %.pl, $^) $(filter-out %.pl, $^) > $@

-include target.mk

screens: 
	git clone https://github.com/dushoff/screens.git

update:
	(cd */linux_config || cd */*/linux_config) && make pull

start:
	cd screens && make start
