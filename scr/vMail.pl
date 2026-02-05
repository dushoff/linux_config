use strict;
use 5.10.0;

while(<>){
	chomp;
	s/##.*//;
	next if /^\W*$/;
	s/(.*)\t(.*)/"$1" <$2>/;
	say;
}
