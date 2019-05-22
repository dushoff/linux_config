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

findTab: bin/findTab
	$@ Chrome Gmail 12

######################################################################

Sources += README.md

## Installation logs (see README.md)

## Logs of how I install things
Sources += $(wildcard log/*.log)

######################################################################
## We can add a directory by giving it a Makefile and alling (bin)
## Or by just sourcing from here (home)

## Stuff for bin
subdirs += bin 
linkbin:
	cd ~ && ln -fs $(CURDIR)/bin

## There are other files in linux/home that I haven't looked at
## cp ~/Dropbox/linux/home/.??* home ##
Ignore += home
Sources += $(wildcard home/.??* home/*)
linkhome:
	cd ~ && ln -fs $(CURDIR)/home/.??* $(CURDIR)/home/*.*

######################################################################

## Root directory Makefile
Sources += tilde.mk gg.pl
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

