## This is linux_config

-include target.mk

-include makestuff/perl.def

vim_session:
	bash -cl "vmt main.keys tilde.mk ~/.vimrc ~/.vimrc.personal ~/.baliases log.md"

######################################################################

Sources += README.md TODO.md

# Installation logs (see README.md)

## Logs of how I install things
Sources += $(wildcard log/*.log log/*.mac log/token*)

Sources += log.md

log.filemerge: log.md

######################################################################

## Remarkable config

Sources += rmview.json
## /home/dushoff/.config/rmview.json

######################################################################

## nvim/ghost stuff

## dushoff@Tellurium:~/screens/tech$ netstat -lntup 

## neovim start here I guess
nvimlink: init.vim ~/.config/nvim
	cd ~/.config/nvim && ln -fs $(CURDIR)/$<

~/.config/nvim:
	$(mkdir)

Sources += init.vim

######################################################################

## These need to be redone for major reshuffles 2019 Aug 30 (Fri)
relink: linkmake linkbin linkhome nvimlink

## Stuff for bin
linkbin:
	cd ~ && ln -fs $(CURDIR)/bin

## There are other files in linux/home that I haven't looked at
## cp ~/Dropbox/linux/home/.??* home ##
subdirs += home bin
alldirs += $(subdirs)

linkhome:
	cd ~ && ln -fs $(CURDIR)/home/.??* $(CURDIR)/home/*.* .

Sources += ssh.Makefile
linkssh: ~/.ssh ~/.ssh/authorized_keys
	cd ~ && ln -fs $(CURDIR)/ssh.Makefile .ssh/Makefile

~/.ssh:
	cd ~ && $(MD) .ssh && chmod 700 .ssh

~/.ssh/authorized_keys:
	cd $(dir $@) && touch $(notdir $@)  && chmod 640 $(notdir $@) 

######################################################################

## I'm preferring link now, because it allows me to edit the copy when I feel like.
## relink should solve any problem -- unless we delete _all_ versions of this repo before successfully installing a new location

linkmake:
	cd ~ && ln -fs $(CURDIR)/tilde.mk Makefile

pushmake:
	$(CPF) tilde.mk ~/Makefile
	chmod a-w ~/Makefile

Ignore += $(subdirs)

alldirs += $(subdirs)

malldirs.var:

######################################################################

## Keyboard shortcuts

Sources += $(wildcard *.pl)

Sources += main.keys
Ignore += *.conf

## main.load: main.keys main.conf
%.load:  %.conf
	dconf load / < $<

## Bindings are hashed to commands, so we can only have one binding per command
## Right now we have silent overrides
## Solution is to have arrays of bindings,
## but this requires a little bit of extra counting
.PRECIOUS: %.conf
Ignore += .conf
%.conf: %.keys keys.pl
	$(PUSH)

Ignore += win.list
win.list: listWins.pl
	$(PUSH)

Ignore += $(subdirs)

######################################################################

## non-repo Makefiles
Sources += tilde.mk 
Sources += $(wildcard Dropbox/*.mk)

Dropbox/%.mk:
	cp makestuff/nogit.Makefile $@
	cd ~/Dropbox/$* && ln -s $(CURDIR)/$@ Makefile

######################################################################

mirrors += lakes meadows

######################################################################

## Makestuff setup
Sources += Makefile 
msrepo = https://github.com/dushoff
ms = makestuff
-include makestuff/os.mk

Ignore += makestuff
Makefile: makestuff/01.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

### Makestuff rules

-include makestuff/git.mk
-include makestuff/mirror.mk
-include makestuff/visual.mk
