#! /usr/bin/perl

use strict;
use 5.10.0;

while(<>){
	s/\s+comma\b/,/g;
	s/\s+period full stop\b/./g;
	s/\s+full stop\b/./g;
	s/\s+question mark\b/?/g;
	s/\s+exclamation point\b/!/g;
	s/\s+new paragraph\b/\n\n/g;
	s/ Cohen$/:/;
	s/ Cullen$/:/;
	s/you of tea/U of T/g;
	s/the I see you/the ICU/g;
	s/Fitzhugh/fits/g;
	s/Juliette/Juliet/g;
	s/Benjamin Button/Bolker/g;
	s/White'*s/Weitz/g;
	s/Loop in/loop in/g;
	s/\s+colon\b/: /;
	s/\bdash\b/–/gi;
	s/Pete/epiEstim/g;
	s/ISIS/ICES/gi;
	s/Kenyatta/Nkengafac/g;
	s/sanatorium/Sana/gi;
	s/beagles/Bicko's/gi;
	s/beagle/Bicko/gi;
	s/Captain Awesome/Faikah/gi;
	s/paisan/Zinhle/gi;
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
	s/vanadium/vareffects/g;
	s/Elmer Fudd/lme4/g;
	s/Steve Kenya/Bicko/g;
	s/Gothenburg/Gauteng/g;
	print;
}
