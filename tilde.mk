## This file is the Makefile for ~dushoff, curated in linux_config

target:
	touch *.png
	mv *.png Downloads

start setup makescreen:
	cd screens && make $@

relink:
	cd */*/linux_config && $(MAKE) relink
