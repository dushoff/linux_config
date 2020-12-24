
## A nogit Makefile for Dropbox archive

-include target.mk

vim_session: 
	bash -cl "vmt"

-include makestuff/perl.def

######################################################################

index.filemerge: index.md

######################################################################

BASE = ~/screens
Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls $(BASE)/makestuff/Makefile && /bin/ln -s $(BASE)/makestuff 

-include makestuff/os.mk
-include makestuff/visual.mk
