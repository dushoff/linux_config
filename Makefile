## This is linux_config

-include target.mk

-include makestuff/perl.def

vim_session:
	bash -ic "vmt i3.bind.conf i3.config i3.ws.conf ~/.vimrc ~/.vimrc.personal ~/.baliases log.md"

######################################################################

Sources += $(wildcard *.md)
## TODO.md and README.md seem very old.
 
## Logs of how I install things
Sources += $(wildcard log/*.log log/*.mac log/token*)

Sources += log.md

Log.filemerge: log.md

######################################################################

## Remarkable config

Sources += rmview.json
## /home/dushoff/.config/rmview.json

######################################################################
Sources += bash.md

## These need to be redone for major reshuffles 2019 Aug 30 (Fri)
relink: linkmake linkbin linkhome

newbin: exec
	cd ~ && rm bin && mkdir bin

## Stuff for bin
linkbin:
	cd ~/bin && ln -fs $(CURDIR)/scr && ln -fs $(CURDIR)/exe

sex:
	chmod a+x scr/*.sh scr/*.pl scr/*.py

exec: | exe
	chmod -R a+x exe/

script: | scr
	chmod -R a+x scr/

nextclean: 
	rm -fr ~/.local/share/Nextcloud/ ~/bin/*/Next*

## There are other files in linux/home that I haven't looked at
## cp ~/Dropbox/linux/home/.??* home ##
subdirs += home scr
alldirs += $(subdirs)

linkhome:
	cd ~ && ln -fs $(CURDIR)/home/.??* $(CURDIR)/home/*.* .

######################################################################

Sources += i3.md i3.config
Sources += i3.bind.conf i3.ws.conf
Sources += workspace.json

i3Check:
	i3 -C

## Log in with debugging to use this log; not tried 2026 May 12 (Tue)
## i3com.restart: ~/.cache/i3-debug.log
## i3com.reload:
i3com.%:
	i3-msg $*

~/.config/%/:
	$(mkdir)

linki3: | ~/.config/i3/
	cd $| && ln -fs $(CURDIR)/i3.config config

######################################################################

## X

## xdpyinfo | grep resolution
## cat ~/.Xresources | grep -i dpi
## grep -r "font" ~/.config/alacritty/
## echo "Xft.dpi: 120" > ~/.Xresources
## xrdb -merge ~/.Xresources

######################################################################

## alacritty alacolors.md

## Remake the profile if you edit
## all are currently on tomorrow except siX is on tomorrow_small

Sources += bare.toml $(wildcard *.al.toml)
Ignore +=  alacritty.toml
## tomorrow is current preferred for desktops
## tomorrow.profile: tomorrow.al.toml alacolors.md
## tomorrow_small.profile: tomorrow_small.al.toml

## selenized_dark.profile: selenized_dark.al.toml

## Override suggestions from Claude
## hi_overrides.md

## catppuccin_mocha.profile: catppuccin_mocha.al.toml

## These are not good
## tomorrow_night_eighties.profile: tomorrow_night_eighties.al.toml 
## tomorrow_night.profile: tomorrow_night.al.toml ## Contrasts acceptable but not good allinone

## These are not good
## GruvLight.profile: GruvLight.al.toml
## GruvDark.profile: GruvDark.al.toml

## bare.al.profile: bare.al.toml ## Bad for hl; too dark for daytime on allinone
%.profile: %.al.toml /home/dushoff/.config/alacritty/alacritty.toml
	$(CP) $< alacritty.toml
.PRECIOUS: %.al.toml
%.al.toml: | bare.toml
	$(pipecopy)

/home/dushoff/.config/alacritty/alacritty.toml: Makefile | ~/.config/alacritty/
	cd $| && ln -fs $(CURDIR)/alacritty.toml

Sources += *.i3conf
## siX.i3file: siX.i3conf i3.local.conf
## fiVe.i3file: fiVe.i3conf i3.local.conf

## xclip -o -selection primary

Ignore += *.local.conf
## xiangshan.i3file: xiangshan.i3conf i3.local.conf
%.i3file: | %.i3conf
	$(LN) $| i3.local.conf

Sources += zathurarc
linkz: | ~/.config/zathura/ zathurarc
	cd $| && ln -fs $(CURDIR)/zathurarc

######################################################################

Sources += ssh.Makefile
linkssh: ~/.ssh ~/.ssh/authorized_keys
	cd ~ && ln -fs $(CURDIR)/ssh.Makefile .ssh/Makefile

~/.ssh:
	cd ~ && $(MD) .ssh && chmod 700 .ssh

~/.ssh/authorized_keys:
	cd $(dir $@) && touch $(notdir $@)  && chmod 640 $(notdir $@) 

######################################################################

linkmake:
	cd ~ && ln -fs $(CURDIR)/tilde.mk Makefile

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

mirrors += lakes meadows exe alerts

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


## Makestuff setup
Sources += Makefile 
msrepo = https://github.com/dushoff
ms = makestuff
-include makestuff/os.mk

Ignore += makestuff
Makefile: makestuff/04.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

### Makestuff rules

-include makestuff/git.mk
-include makestuff/mirror.mk
-include makestuff/visual.mk
