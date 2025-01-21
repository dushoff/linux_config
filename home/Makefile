## .vimrc.personal.0dd0a02.oldfile
## .baliases.16784f42.oldfile

## Shadow directory for ~

current: target
-include target.mk

##################################################################

## Defs

Sources += Makefile

ms = makestuff

Ignore += $(ms)
Makefile: $(ms)/Makefile
	touch $@
$(ms)/Makefile:
	ls ../makestuff/Makefile && /bin/ln -s ../makestuff 

-include $(ms)/os.mk

######################################################################

## Importing and linking from Dropbox 2019 Jan 15 (Tue)
resting = .pinerc 
files = .addressbook .aliases .baliases .bashrc .blocal.ubuntu .cshrc .escreenrc .gcvimrc .gmvimrc .gpvimrc .gvimfont .gvimrc .pvimrc .rgvimrc .screenrc .tgvimrc .tvimrc .vimrc .vimrc.basic .vimrc.break .vimrc.iat .vimrc.jdiat .vimrc.make .vimrc.nomake .vimrc.personal .vimrc.prev .vimrc.tat .vimrc.tex .vimrc.twitter .vimrc.windows 
files += .vimrc.ab .vimrc.dig .vimrc.au .vimrc.newabb .vimrc.focal
files += .nvim.ghost .nvim.mail

Sources += $(files)

linkhome:
	cd ~ && ln -fs $(CURDIR)/.??* $(CURDIR)/*.* .

ubuntu:
	cd ~ && ln -fs $(CURDIR)/.blocal.ubuntu .blocal

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

