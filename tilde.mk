-include target.mk

main: main.start
	screen -S $@ -p 0 -X exec make $@.screens
	screen -x main

main.start:
	! screen -x main && screen -c .escreenrc -dm main

main.screens: 
	$(MAKE) ..subscreen gitroot.subscreen Dropbox.subscreen
	$(MAKE) gitroot/3SS.subscreen
	$(MAKE) gitroot/708.subscreen
	$(MAKE) gitroot/Workshops.subscreen

now: gitroot/708.subscreen

## Attach a screen as a subscreen of this one
## "makes" it exist first
## Should probably make sure we're in a screen – but how?
## Also, what about making the directory?
%.subscreen: %.makescreen
	screen -t $(notdir $*) screen -x $(notdir $*)

## Find a screen with this name or make a new one
%.makescreen:
	screen -S $(notdir $*) -p 0 -X select 0 || $(MAKE) $*.newscreen

## bash -cl "deskstart" ## Does not work in this context
## Trying something else 2019 Jan 21 (Mon)
screen_session:
	echo deskstart | bash -l
	screen -t run
	cd R && screen -t R
	screen tcsh
	screen -t sudo sudo su

## Make a new screen and fill in its windows
## Picks up subshell if run from inside vim!
## Is first line necessary at all?
%.newscreen:
	cd $* && screen -dm $(notdir $*)
	screen -S $(notdir $*) -p 0 -X exec make screen_session

## Stopping in the middle; be more thoughtful about this.
chyun.newscreen:
	cd gitroot && screen -dm chyun

######################################################################

test: test.start
	screen -S $@ -p 0 -X exec make test.screens
	screen -x test

test.start:
	screen -dm test

test.screens:
	cd Dropbox && screen -t Dropbox
	bash -cl "sd gitroot"
