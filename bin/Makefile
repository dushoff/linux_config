
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
resting = csv2html/ k2pdfopt pad/

## Source scripts, Ignore links
links = base16-gnome-terminal dropbox.py make2graph

## pad (not checked 2020 May 23 (Sat))
scripts += n17 nono nopad noscreen o17 opad oscreen pado screeno 

## Commands
scripts += sdir ship tat.pl vi pdfwin cpdf bat tat.pl

## Glue # make these scripts use General focus
scripts += sleepy wakey

## General focus
scripts += findTab windows pickscreen findApp findwin

## Special focus (deprecate 2020 May 23 (Sat), careful with the first one)
scripts += term
scripts += focus jumpy voicewin chromewin mailwin hangwin textcal report 
scripts += textdemon

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
