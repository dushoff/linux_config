
# If we place public things elsewhere from here, that allows them to
# verify that we are real (since we have the private part here) and
# should thus allow us to log on to them.

## local.mk needs USER variable (or target-specific variables)
-include local.mk

place_%: id_rsa.pub
	cat $< | ssh $(USER)@$* cat - ">>" ~/.ssh/authorized_keys
	touch $@

id_rsa id_rsa.pub:
	ssh-keygen -t rsa

%.rmk:
	/bin/rm -f $*
	$(MAKE) $*
