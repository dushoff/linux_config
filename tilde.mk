## This file is the Makefile for ~dushoff, curated in linux_config

PUSH = perl -wf $(filter %.pl, $^) $(filter-out %.pl, $^) > $@

-include target.mk

screens: 
	git clone https://github.com/dushoff/screens.git

update:
	(cd */linux_config && make pull) || (cd */*/linux_config && make pull)

start:
	cd screens && make start
