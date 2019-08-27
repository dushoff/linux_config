## NO makestuff here
## This file is the Makefile for ~dushoff, but is curated in linux_config

PUSH = perl -wf $(filter %.pl, $^) $(filter-out %.pl, $^) > $@

-include target.mk

## Aim to move $@.screens into .start; if main exists don't assume screens don't
## This should eventually work like generic ones below, but with .escreenrc

first: config psync
start: config psync main

config:
	cd gitroot && make pull
	cd gitroot/linux_config && make pull

psync:
	cd gitroot/Planning && make pull

main: main.start
	screen -S $@ -p 0 -X exec make $@.screens
	screen -x main

main.start:
	! screen -x main && screen -c .escreenrc -dm main

main.screens: 
	$(MAKE) local.subscreen gitroot.subscreen Dropbox.subscreen
	## $(MAKE) gitroot/3SS.subscreen
	## $(MAKE) gitroot/708.subscreen
	$(MAKE) gitroot/Workshops.subscreen
	screen -S local -p 0 -X stuff "deskstart"

######################################################################

## What's the difference between subscreen and gitscreen?
## gitscreen is gitroot based, which is confusing
## Attach a screen as a subscreen of this one
## "makes" it exist first
## Should probably make sure we're in a screen – but how?
## Also, what about making the directory?
## Also, how to get auto-focus? Seems hard

## Make a screen if necessary and attach as a subscreen to ctrl-e-screeen
%.subscreen: %.makescreen
	screen -t $(notdir $*) screen -x $(notdir $*)

## Find a screen with this name or make a new one
%.makescreen:
	cd $(dir $*) && $(MAKE) $(notdir $*)
	screen -S $(notdir $*) -p 0 -X select 0 || $(MAKE) $*.newscreen

## local removed 2019 May 25 (Sat). Will it come back?
local:
	@echo pretend to make local directory

######################################################################

## Make a screen following rules in its directory
## Should be called dirscreen and merged with rules below

## Make a new screen and fill in its windows
## Picks up subshell if run from inside vim! Should fix somehow
## Change to directory name but stay here if local
sdm = screen -dm $(notdir $*)
%.newscreen:
	(cd $* && $(sdm)) || $(sdm)
	screen -S $(notdir $*) -p 0 -X exec make screen_session

######################################################################

## Make a screen following rules here
## gitscreens are made in ~, but populated using rules in gitroot

## Stopping in the middle; be more thoughtful about this.
## chyun.gitscreen:
%.gitscreen: %.gitstart
	screen -t $* screen -x $*

%.gitstart:
	screen -S $* -p 0 -X exec ls || (cd gitroot && screen -dm $* && screen -S $* -p 0 -X exec make $*.screens)

## Does making this file allow us to auto-complete
include gitscreen.mk
gitscreen.mk: gitroot/screen.mk gitroot/linux_config/gg.pl
	$(PUSH)

######################################################################

## screen_session rules (for the screen formerly known as local, based here)

## bash -cl "deskstart" ## Does not work in this context
## Trying something else 2019 Jan 21 (Mon)
## Trying something else 2019 Apr 01 (Mon)
screen_session:
	screen -t run
	cd R && screen -t R
	screen tcsh
	screen -t sudo sudo su

test: test.start
	screen -S $@ -p 0 -X exec make test.screens
	screen -x test

test.start:
	screen -dm test

test.screens:
	cd Dropbox && screen -t Dropbox
	screen -t run
	screen -S test -p 2 -X stuff "deskstart"
