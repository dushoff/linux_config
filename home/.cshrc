# set path = (. ~/bin /bin /usr/local /usr/local/bin /usr/ucb /usr/bin /share/bin /usr/etc)

# export PATH="$HOME/.rbenv/bin:$PATH"
set path = (. ~/.rbenv/bin ~/bin /usr/local/bin /bin /usr/bin ~/.rubies/ruby-2.1.3/bin /usr/local/sge/bin/linux-x64/)

#         set this for all shells
setenv SHELL tcsh
setenv REPLYTO dushoff@mcmaster.ca
setenv EDITOR '/usr/bin/gvim -f'

setenv SGE_ROOT /usr/local/sge
setenv SGE_CELL default
setenv SGE_CLUSTER_NAME sgeonyushan
setenv SGE_QMASTER_PORT 6444

setenv MYSQL /var/lib/mysql

setenv BASE ${HOME}/

source ~/.aliases

if ($?USER == 0 || $?prompt == 0) exit

set history=40 savehist=20
set ignoreeof

unset noclobber
unsetenv SCREENDIR

# OPAM configuration
# <OCAML stuff from Alejo>
source /home/dushoff/.opam/opam-init/init.csh >& /dev/null || true

# RBENV stuff (edited from .bashrc)
# rbenv init -
