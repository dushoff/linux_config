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
	bash -cl "vmt main.keys tilde.mk"

######################################################################

Sources += README.md

# Installation logs (see README.md)

## Logs of how I install things
Sources += $(wildcard log/*.log)

######################################################################
## We can add a directory by giving it a Makefile and alling (bin)
## Or by just sourcing from here (home)

## These need to be redone for major reshuffles 2019 Aug 30 (Fri)
## ~/Makefile is now "pushed" – consider for other files? Don't want them to just disappear.
relink: linkmake linkbin linkhome

## Stuff for bin
subdirs += bin 
linkbin:
	cd ~ && ln -fs $(CURDIR)/bin

## There are other files in linux/home that I haven't looked at
## cp ~/Dropbox/linux/home/.??* home ##
subdirs += home

linkhome:
	cd ~ && ln -fs $(CURDIR)/home/.??* $(CURDIR)/home/*.* .

######################################################################

## Root directory Makefile
Sources += tilde.mk 

## I'm preferring link now, because it allows me to edit the copy when I feel like.
## relink should solve any problem -- unless we delete _all_ versions of this repo before successfully installing a new location

linkmake:
	cd ~ && ln -fs $(CURDIR)/tilde.mk Makefile

pushmake:
	$(CPF) tilde.mk ~/Makefile
	chmod a-w ~/Makefile

Ignore += $(subdirs)

######################################################################

## Keyboard shortcuts

Sources += $(wildcard $.pl)

Sources += main.keys
Ignore += *.conf

## main.load: main.keys
%.load:  %.conf
	dconf load / < $<

.PRECIOUS: %.conf
Ignore += .conf
%.conf: %.keys keys.pl
	$(PUSH)

Ignore += win.list
win.list: listWins.pl
	$(PUSH)

Ignore += $(subdirs)

######################################################################

### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

