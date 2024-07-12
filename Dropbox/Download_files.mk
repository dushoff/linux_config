## Download_files Makefile
## A nogit Makefile for Download files
## When you archive a Downloads folder:
## copy the old-folder Makefile to the new folder

2407.newDown:
%.newDown:
	- cd ~/Dropbox/Download_files && mkdir $* && cp ~/Downloads/Makefile $*
	ls ~/Dropbox/Download_files/$*
	cd ~ && rm Downloads && ln -s ~/Dropbox/Download_files/$* Downloads
	cd ~/Downloads && $(MAKE) makestuff && $(MAKE) target.mk

## 2407.newcomputer:
%.newcomputer:
	- mv ~/Downloads ~/tmpDownloads
	cd ~ && ln -s ~/Dropbox/Download_files/$* Downloads
	- mv ~/tmpDownloads ~/Downloads/

######################################################################

-include makestuff/os.mk
-include makestuff/visual.mk
