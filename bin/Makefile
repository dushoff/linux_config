
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

links = base16-gnome-terminal dropbox.py make2graph

scripts = focus jumpy n17 nono nopad noscreen o17 opad oscreen pado screeno sdir ship sleepy tat.pl term vi wakey voicewin chromewin mailwin hangwin calwin pdfwin compwin cpdf findTab bat report

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

