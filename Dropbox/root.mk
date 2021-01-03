## Main Dropbox makefile. The point is for screen_session
## This is a symlink to linux_config

-include target.mk

Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls ~/screens/makestuff/Makefile && /bin/ln -s ~/screens/makestuff 

-include makestuff/os.mk

######################################################################

vim_session:
	bash -cl "vmt index.md"

screen_session:
	$(MAKE) ~/Downloads.rscreen

all.time: ;

pull: ;

notes += index.md

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
# -include makestuff/oldlatex.mk
