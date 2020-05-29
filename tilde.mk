## This file is the Makefile for ~dushoff, curated in linux_config

start setup makescreen:
	cd screens && make $@

relink:
	cd */*/linux_config && $(MAKE) relink
