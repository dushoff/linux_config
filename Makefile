## Target
current: target
-include target.mk

## Makestuff setup
Sources += Makefile 
msrepo = https://github.com/dushoff
ms = makestuff
-include $(ms)/os.mk

Ignore += $(ms)
Makefile: $(ms)/Makefile
$(ms)/Makefile:
	git clone $(msrepo)/$(ms)
	ls $@

-include $(ms)/perl.def

vim_session:
	vim Makefile target.mk tilde.mk

## Move windows.pl some day to bin and bind it to a key
## It finds the mail window even if it's hiding.
## You can reverse the loop to make it less jumpy
## Sources += windows.pl
Ignore += windows.out
windows.out: windows.pl
	$(PUSH)

findTab: Makefile windows.pl
	./windows.pl Chrome Gmail

######################################################################

Sources += README.md

## Installation logs (see README.md)

## Logs of how I install things
Sources += $(wildcard log/*.log)

######################################################################

## Stuff for bin
subdirs += bin 
linkbin:
	cd ~ && ln -fs $(CURDIR)/bin

######################################################################

## Root directory Makefile
Sources += tilde.mk
linkmake:
	cd ~ && ln -fs $(CURDIR)/tilde.mk Makefile

Ignore += $(subdirs)

######################################################################

## Keyboard shortcuts

Sources += main.keys keys.pl
Ignore += *.conf

## main.load: main.keys
%.load:  %.conf
	dconf load / < $<

.PRECIOUS: %.conf
Ignore += .conf
%.conf: %.keys keys.pl
	$(PUSH)

######################################################################

### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

