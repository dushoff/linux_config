
## This uses old-fashioned tools but seems to work
## See https://www.ssh.com/ssh/copy-id for more modern advice

######################################################################

# Set up server logins

# If we place public things elsewhere from here, that allows them to
# verify that we are real (since we have the private part here) and
# should thus allow us to log on to them.

## Add USER variable (or target-specific variables USER variables?) if necessary
-include local.mk

## place_jdserv.mcmaster.ca: Does not work
## place_ms.mcmaster.ca ##
## place_mbx.mcmaster.ca: 
place_%: id_rsa.pub
	cat $< | ssh $(USER)@$* cat - ">>" .ssh/authorized_keys
	touch $@

######################################################################

local: id_rsa.pub
	cat $< >> authorized_keys
	touch $@

id_rsa id_rsa.pub:
	ssh-keygen -t rsa
