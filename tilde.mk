-include target.mk

## Aim to move $@.screens into .start; if main exists don't assume screens don't
## This should eventually work like generic ones below, but with .escreenrc

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
	$(MAKE) ..subscreen gitroot.subscreen Dropbox.subscreen
	$(MAKE) gitroot/3SS.subscreen
	$(MAKE) gitroot/708.subscreen
	## $(MAKE) gitroot/Workshops.subscreen

## What's the difference between subscreen and gitscreen?
## gitscreen is gitroot based, which ic confusing
## Attach a screen as a subscreen of this one
## "makes" it exist first
## Should probably make sure we're in a screen – but how?
## Also, what about making the directory?
%.subscreen: %.makescreen
	screen -t $(notdir $*) screen -x $(notdir $*)

## Find a screen with this name or make a new one
%.makescreen:
	cd $(dir $*) && $(MAKE) $(notdir $*)
	screen -S $(notdir $*) -p 0 -X select 0 || $(MAKE) $*.newscreen

######################################################################

## Make a screen following rules in its directory
## Should be called dirscreen and merged with rules below

## Make a new screen and fill in its windows
## Picks up subshell if run from inside vim!
## Is first line necessary at all?
%.newscreen:
	cd $* && screen -dm $(notdir $*)
	screen -S $(notdir $*) -p 0 -X exec make screen_session

######################################################################

## Make a screen following rules here
## gitscreens are made in ~, but populated using rules in gitroot

## Stopping in the middle; be more thoughtful about this.
## chyun.gitscreen:
%.gitscreen: %.gitstart
	echo ssx $* | bash -l

%.gitstart:
	screen -S $* -p 0 -X exec ls || (cd gitroot && screen -dm $* && screen -S $* -p 0 -X exec make $*.screens)

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
	screen -t deskstart bash -cl "deskstart" ## Does not work in this context

test: test.start
	screen -S $@ -p 0 -X exec make test.screens
	screen -x test

test.start:
	screen -dm test

test.screens:
	cd Dropbox && screen -t Dropbox
	screen -t run
	screen -S test -p 2 -X stuff "deskstart"
