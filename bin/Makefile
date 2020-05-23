
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

resting = cpdf csv2html/ k2pdfopt pad/

## Source scripts, Ignore links
## Make sure to notice the gaps!
links = base16-gnome-terminal dropbox.py make2graph

## pad
scripts += n17 nono nopad noscreen o17 opad oscreen pado screeno 

## Commands
scripts += sdir ship tat.pl vi pdfwin cpdf bat tat.pl

## Glue
scripts += sleepy wakey 
## Special focus
scripts += focus jumpy term voicewin chromewin mailwin hangwin textcal report 

## General focus
scripts += findTab windows pickscreen  findApp

Sources += $(scripts)

Ignore += $(links)
Makefile: $(links)
$(links):
	ls ~/Dropbox/linux/bin/$@
	/bin/ln -fs ~/Dropbox/linux/bin/$@ .

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
