
## A nogit Makefile for Download files
## When you archive a Downloads folder:
## update this file from the old-folder Makefile
## use the updated version for the new-folder Makefile

current: update_copies
-include target.mk

vim_session: 
	bash -cl "vmt"

# -include makestuff/perl.def

##################################################################

## These images are not printable by our printer??
## Is it the density?

######################################################################

%.grey.jpg: %.jpg Makefile
	convert $< -grayscale rec709luma $@

%.sharp.jpg: %.grey.jpg Makefile
	convert $< -level 00%,75%,1.5 $@

%.bw.jpg: %.jpg Makefile
	convert $< -threshold 50% $@

######################################################################

pouyan.init.pdf: pouyan.pdf formDrop/jd.05.pdf
	pdfjam $< 2 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "363 122" \
		-stdin -stdout | \
	cat > $@

pouyan.sign.pdf: pouyan.pdf name.pdf email.pdf text.pdf formDrop/jsig.20.pdf
	pdfjam $< 4 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "60 -453" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "180 -453" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 4, $^) -pos-left "320 -453" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 5, $^) -pos-left "420 312" \
		-stdin -stdout | \
	cat > $@

pouyan.out.pdf: pouyan-0.pdf pouyan.init.pdf pouyan-2.pdf pouyan.sign.pdf
	$(pdfcat)

######################################################################

canmod.pdf: canmod.txt
	pdfroff $< | cpdf -crop "0.9in 10.8in 4.0in 0.25in" -stdin -o $@ 

eidm.pdf: eidm.txt
	pdfroff $< | cpdf -crop "0.9in 10.8in 3.2in 0.25in" -stdin -o $@ 

######################################################################

2001.newDown:
%.newDown:
	- cd ~/Dropbox/Download_files && mkdir $* && cp Makefile $*
	ls ~/Dropbox/Download_files/$*
	cd ~ && rm Downloads && ln -s ~/Dropbox/Download_files/$* Downloads
	cd ~/Downloads && $(MAKE) target.mk

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

remove_conflicts:
	$(RM) *confl*

list_conflicts:
	ls *confl*

##################################################################

# Some extra rules

hagaddah-book.pdf:
%-book.pdf: %.pdf Makefile; pdfbook2 $<

######################################################################

## Some image examples

## Trivial (crop for MOm)
jacob.jpg: 30.jpg
	convert -crop 600x1200+0+0 $< $@

## Color adjustment

nCoV.png: China_corona.png
	convert -scale 80% -colorspace Gray -modulate 111 -crop 750x550+8+50 $< $@

tuna.jpg: tuna-school.jpg
	convert $< -modulate 222 $@

## Backgrounds
image.jpg: image.png
	convert $< -background white -alpha remove $@

## Rotation

## pdfjam --landscape when needed
WallisMH.pdf: scan0001.pdf Makefile
	pdfjam $< --angle 180 -o $@

jd_init.jpg: init.jpg
	convert $< -rotate 270 $@

up_date:

sign: jsig.jpg
	touch $<

## Multiply 800 by date size for range of starting negative offset? Maybe?
date_100.pdf:

rutgers_trans.pdf: reference.pdf formDrop/sig.100.pdf date_2.0.pdf 
	cat $< | \
	cpdf -stamp-on $(word 2, $^) -pos-left "50 228" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1330" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1400" \
		-stdin -stdout | \
	cat > $@

######################################################################

## Secondary ghetto

jdaz.pdf.zip:
.SECONDEXPANSION:
%.pdf.zip: $$(wildcard $$*/_*.pdf)
	$(ZIP)

######################################################################

makestuff.pull:
	cd makestuff && git pull

######################################################################

BASE = ~/screens
Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls $(BASE)/makestuff/Makefile && /bin/ln -s $(BASE)/makestuff 

-include makestuff/os.mk
-include makestuff/visual.mk
