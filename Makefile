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

######################################################################

Sources += README.md

## Logs of how I install things
Sources += $(wildcard log/*.log)

######################################################################

## Stuff for bin
subdirs += bin 
linkbin:
	cd ~ && ln -s $(CURDIR)/bin

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

## New (hotness)
.PRECIOUS: %.conf
%.conf: %.keys keys.pl
	$(PUSH)

######################################################################

### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

