use 5.10.0;
use strict;

my $head="[org/gnome/settings-daemon/plugins/media-keys]";
my $bname = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom";
my $pname = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom";

my %bindings;
while(<>){
	next if /^#/;
	next if /^\s*$/;
	chomp;
	my ($name, $binding) = split;
	$bindings{$name} = $binding
}

say $head;

my @bkeys = keys %bindings;
my @names;
for (my $i=0; $i<@bkeys; $i++){
	push @names, "'$bname$i/'";
}

print "custom-keybindings=[";
print join ", ", @names;
print "]\n\n";

for (my $i=0; $i<@bkeys; $i++){
	my $name = $bkeys[$i];
	say "[$pname$i]";
	say "binding='$bindings{$name}'";
	say "command='$name'";
	say "name='$name'";
	say "";
}
