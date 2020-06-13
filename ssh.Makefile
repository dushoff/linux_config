
# If we place public things elsewhere from here, that allows them to
# verify that we are real (since we have the private part here) and
# should thus allow us to log on to them.

## ML: local.mk needs USER variable (or target-specific variables)
-include local.mk

## ML: Try `make place_ms.mcmaster.ca`. Answer the questions.
## If it works, it should not ask you for a password next time you go there
## place_jdserv.mcmaster.ca: Does not work
## del  place_ms.mcmaster.ca ##
## place_mbx.mcmaster.ca: 
place_%: id_rsa.pub
	cat $< | ssh $(USER)@$* cat - ">>" .ssh/authorized_keys
	touch $@

local: id_rsa.pub
	cat $< >> authorized_keys
	touch $@

id_rsa id_rsa.pub:
	ssh-keygen -t rsa
