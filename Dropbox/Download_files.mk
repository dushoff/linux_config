## Download_files Makefile
## A nogit Makefile for Download files
## When you archive a Downloads folder:
## copy the old-folder Makefile to the new folder
## This is revision controlled for some reason; push and pull to 
## ~/screens/tech/linux_config/Dropbox/Download_files.mk

## 2407.newDown:
%.newDown:
	- cd ~/Dropbox/Download_files && mkdir $* && cp ~/Downloads/Makefile $*
	ls ~/Dropbox/Download_files/$*
	cd ~ && rm Downloads && ln -s ~/Dropbox/Download_files/$* Downloads
	cd ~/Downloads && $(MAKE) makestuff && $(MAKE) target.mk

## Uncommented for bash apparency!
2407.newcomputer:
## This should keep tmpDownloads if it's a real directory
## and ditch it if it's a symbolic link to the thing you're deprecating
%.newcomputer:
	- mv ~/Downloads ~/tmpDownloads
	cd ~ && ln -s ~/Dropbox/Download_files/$* Downloads
	- mv ~/tmpDownloads ~/Downloads/
	$(RM) ~/tmpDownloads

######################################################################

-include makestuff/os.mk
-include makestuff/visual.mk
