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

######################################################################

Sources += README.md

## Logs of how I install things
Sources += $(wildcard log/*.log)

## Stuff for bin
subdirs += bin
linkbin:
	cd ~ && echo $(CURDIR)

### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

