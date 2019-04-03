use strict;
use 5.10.0;

my $maxTabs=12;

my @wins = split /\s+/, `xdotool search --name Chrome`;

for (my $i=0;$i<$maxTabs;$i++){
	my $title;
	foreach my $win (@wins) {
		system ("xdotool windowactivate $win");
		$title = `xwininfo -id $win | grep Gmail`;
		last if $title;
		system("xdotool key --window $win ctrl+Page_Down");
	}
	last if $title;
}
