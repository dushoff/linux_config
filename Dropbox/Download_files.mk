
## Download_files Makefile
## A nogit Makefile for Download files
## When you archive a Downloads folder:
## update this file from the old-folder Makefile
## use the updated version for the new-folder Makefile

2301.newDown:
%.newDown:
	- cd ~/Dropbox/Download_files && mkdir $* && cp Makefile $*
	ls ~/Dropbox/Download_files/$*
	cd ~ && rm Downloads && ln -s ~/Dropbox/Download_files/$* Downloads
	cd ~/Downloads && $(MAKE) makestuff && $(MAKE) target.mk

## 2301.newcomputer:
%.newcomputer:
	- mv ~/Downloads ~/tmpDownloads
	cd ~ && ln -s ~/Dropbox/Download_files/$* Downloads

######################################################################

## Downloads Makefile
## This Downloads Makefile is a Dropbox file
## the permanent version is revision-controlled in the parent directory

######################################################################

current: update_copies
-include target.mk

vim_session: 
	bash -cl "vmt"

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

list_conflicts:
	ls *confl*

remove_conflicts:
	$(RM) *confl*

######################################################################

%.filenames: 
	rename "s/ /_/g; s/,//g; s/-//;" $*/*.*
	
%.ls: %.filenames
	ls $*/*.* > $@

##################################################################

## EPL service
## https://www.espn.com/soccer/standings/_/league/eng.1

######################################################################

Bicko_requisition.lpr.pdf: Bicko_requisition.pdf
	lpr -P PDF < $<
	sleep 2
	$(MV) ~/PDF/*.* $@

Bicko_test.pdf: Bicko_requisition.lpr.pdf
	pdfjam $< 2 -o /dev/stdout | \
	cat > $@

Bicko_request.pdf: Bicko_requisition.lpr.pdf formDrop/jsig.50.pdf Makefile
	pdfjam $< 2 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "25 72" \
		-stdin -stdout | \
	pdfjam /dev/stdin 1 $< 3 -o $@

######################################################################

sfu_page.pdf: sfu_form.pdf
	pdfjam $< 3 -o $@

sfu_signed.pdf: sfu_page.pdf formDrop/jsig.25.pdf name_1.3.pdf date_1.3.pdf
	cat $< | \
	cpdf -stamp-on $(word 2, $^) -pos-left "340 390" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "270 -630" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 4, $^) -pos-left "270 -650" \
		-stdin -stdout | \
	cat > $@

sfu_combined.pdf: sfu_form.pdf sfu_signed.pdf Makefile
	pdfjam -o $@ $< 1,2 $(word 2, $^) 1 $< 4,5

######################################################################

abx.bw.jpg: abx.jpg Makefile
	convert $< -threshold 45% $@

######################################################################

htmldirs = $(wildcard *_files)
hdirzip: $(htmldirs:_files=.html.tgz)
%.html.tgz:
	tar czf $@ $*.html $*_files
	$(RMR) $*.html $*_files

%.dir.tgz:
	tar czf $@ $*
	$(RMR) $*

######################################################################

jdsquare.jpg: jdhead.jpg
	convert -crop 1500x1500+460+135 $< $@

pr.jpg: prbig.jpg
	convert -crop 2000x2800+444+112 $< $@

##################################################################

## Try to get sound from the dancing babies video
# ffmpeg -i PA090140.avi -vn -acodec copy jump.aac

## Cribbing (broken? 2023 Jan 24 (Tue))
olddir = /home/dushoff/Dropbox/Download_files/XXXX/
%: $(olddir)/%
	$(copy)

######################################################################

## Process downloaded zip files of pdfs

fieldsApps2206.zipdir:
regamrequest.zip:

SACEMA2205.zipdir.filemerge: SACEMA2205.zipdir.md

## This seems better; make last zipfile into a single pdf
## olumide.lz.pdf: olumide.zip

## mcheck.zipdir:
%.zipdir:
	mkdir $@
	$(MAKE) $*.zipadd

%.zipadd:
	cp `ls -t *.zip | head -1` $*.zipdir
	cd $*.zipdir && unzip *.zip && $(RM) *.zip

%.dir.pdf: %
	pdfjam -o $@ $*/*.pdf

## This one makes a zipdir (and drops that indicator)
%.lz.pdf: %.zipdir
	pdfjam -o $@ $</*.pdf

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

## Highlighting

tulio.highlight.png: tulio.png Makefile
	convert -region 400x50+165+550 +level-colors black,gold $< $@

moveon.highlight.png: moveon.png
	convert -region 275x10+815+380 +level-colors black,gold $< $@

######################################################################

## Signing

up_date:

sign: jsig.jpg
	touch $<

## Multiply 800 by date size for range of starting negative offset? Maybe?
date_100.pdf:

rutgers_trans.pdf: reference.pdf formDrop/jsig.100.pdf date_2.0.pdf 
	cat $< | \
	cpdf -stamp-on $(word 2, $^) -pos-left "50 228" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1330" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1400" \
		-stdin -stdout | \
	cat > $@

ccsign.pdf: cc.pdf formDrop/csig.40.pdf date_2.0.pdf 
	pdfjam $< 4 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "120 120" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "-20 -1470" \
		-stdin -stdout | \
	cat > $@

cccombine.pdf: cc.pdf ccsign.pdf
	pdfjam -o $@ $< 1-3 $(word 2, $^)

Pictures:
	/bin/ln -s ~/Pictures .

######################################################################

autopipeR = defined

######################################################################

## Secondary ghetto

jdaz.pdf.zip:
.SECONDEXPANSION:
%.pdf.zip: $$(wildcard $$*/_*.pdf)
	$(ZIP)

######################################################################

BASE = ~/screens
Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls $(BASE)/makestuff/Makefile && /bin/ln -s $(BASE)/makestuff 

-include makestuff/pipeR.mk
-include makestuff/rmd.mk
-include makestuff/pandoc.mk
-include makestuff/forms.mk

-include makestuff/os.mk
-include makestuff/visual.mk
