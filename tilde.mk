# This file is the Makefile for ~dushoff, curated in linux_config

glerbs = $(wildcard *.png Webcam/*.jpg)

target:
	touch $(glerbs)
	mv $(glerbs) Downloads

start setup mainscreen:
	cd screens && make $@

relink:
	cd */*/linux_config && $(MAKE) relink

Downloads:
	ln -s `ls -d ~/Dropbox/Download_files/[1-9]* | tail -1` $@

inc:
	ln -fs screens/org/Planning/inc
