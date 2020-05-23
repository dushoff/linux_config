use strict;

## Right now, only look at one tab per window

my @wins = split /\s+/, `xdotool search .`;

my $maxTabs=1;
foreach my $win (@wins){
	for (my $i=0;$i<$maxTabs;$i++){
		print `xwininfo -id $win`;
		print `xprop -id $win`;
		system ("xdotool windowactivate $win");
		## system("xdotool key --window $win ctrl+Tab");
	}
}
