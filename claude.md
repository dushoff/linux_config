We're going to give up on the spacebox target. I'm thinking of a hotkey that I can use after I make .space.

This should call a script called wsmail.sh. That script should:
find a gmail container in the focused workspace || find any chrome container in the focused workspace || make a new tabbed container and open "google-chrome --new-window https://mail.google.com/mail/u/0/#label/$*"

where $* represents the focused container

