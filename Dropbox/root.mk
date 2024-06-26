## Main Dropbox makefile. The point is for screen_session
## This is a symlink to linux_config

-include target.mk

runscreen: ;

Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls ~/screens/makestuff/Makefile && /bin/ln -s ~/screens/makestuff 

######################################################################

## Curation

## index.md (not git tracked)

notes += index.md

######################################################################

jpgs.md: Makefile
	find . -name *.jpg > $@
	find . -name *.jpeg >> $@
	find . -name *.JPG >> $@
	find . -name *.JPEG >> $@

######################################################################

vim_session:
	bash -cl "vmt index.md"

screen_session:
	$(MAKE) Downloads.vscreen
	$(MAKE) money.vscreen

Downloads:
	ls -dt Download*/* 

pull: ;

##################################################################

## Make a subdirectory with a nogit Makefile

lconfig = ~/screens/tech/linux_config
%.mf: %.sd
	ls $*/Makefile || (cd $(lconfig) && $(MAKE) Dropbox/$*.mk)

%.sd:
	(ls -d $* > /dev/null) || mkdir $*

######################################################################

## db.scr: debugging Dropbox sb issue

## Local links

######################################################################

-include makestuff/visual.mk
-include makestuff/drop.mk
-include makestuff/os.mk
