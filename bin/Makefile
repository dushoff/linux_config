
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

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

