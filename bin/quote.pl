#! /usr/bin/perl

use strict;
use 5.10.0;

while(<>){
	s/Juliette/Juliet/g
	s/\s+colon$/: /;
	s/\bdash\b/–/gi;
	s/Pete/epiEstim/g;
	s/ISIS/ICES/gi;
	s/Kenyatta/Nkengafac/g;
	s/Captain Awesome/Faikah/gc;
	s/Mac pan/MacPan/g;
	s/champagne/MacPan/g;
	s/ oh,/,/g;
	s/\bthis up\b/the supp/g;
	s/a notated/annotated/g;
	s/Marcia/Reshma/g;
	s/Marsha/Reshma/g;
	s/Nina's Mom/Cari/gi;
	s/Manuel/manual/g;
	s/Repose/repos/g;
	s/Arnold/R0/g;
	s/\s*semi:/;/g;
	s/Fungo/Chyun/g;
	s/Macy's/SACEMA/g;
	s/afro/AFRO/g;
	s/icebound/ICI3D/gi;
	s/Georgian/Bayesian/g;
	s/freakish/frequentist/g;
	s/Massif/MSAF/gi;
	print;
}
