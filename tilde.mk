## This file is the Makefile for ~dushoff, curated in linux_config
## It should be a link, not a copy. Use `make relink` (there) to fix

-include target.mk

screens: 
	git clone https://github.com/dushoff/screens.git

start screenstart setup buildscreen:
	cd screens && make $@

update:
	(cd screens/linux_config && make pull) || (cd screens/*/linux_config && make pull)
