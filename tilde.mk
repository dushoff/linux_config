-include target.mk

main:
	screen -x main || (screen -c .escreenrc -dm main && screen -x main)

main.start: 
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

## Where are we with deskstart?
screen_session:
	bash -cl "deskstart"
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
## Also, this is a linked file; edit it at home
chyun.newscreen:
	cd gitroot && screen -dm chyun
