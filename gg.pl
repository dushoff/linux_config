use 5.10.0;
use strict;

while(<>){
	chomp;
	s/#.*//;
	next unless s/screens:.*/gitscreen:/;
	say;
}
