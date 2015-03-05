#!/usr/bin/perl
use Time::localtime;

$tm = localtime;     # get actual date
$y = $tm->year+1900; # year
$m = ($tm->mon)+1;   # month
if ( length($m) == 1 ) { $m = "0".$m; } # two digits format
$d = $tm->mday;      # day
if ( length($d) == 1 ) { $d = "0".$d; } # two digits format

sub print_output {
    foreach $key ( keys %run) {
	$l_shoes = length($key);

	if ( $l_shoes >= 16 ) {
	    print "$key\t$run{$key}km\n";
	} elsif ( $l_shoes >= 8 ) {
	    print "$key\t\t$run{$key}km\n";
	} else {
	    print "$key\t\t\t$run{$key}km\n";
	}
    }
    return;
}

sub write_file {
    open(my $fo, '>>', $dir.$filename)
	or die "Could not open file '$filename' $!";
    
    $l_shoes = length($shoes_name);
    
    if ( $l_shoes >= 16 ) {
	printf $fo "$shoes_name\t$s_km\t$d.$m.$y\n";
    } elsif ( $l_shoes >= 8 ) {
	printf $fo "$shoes_name\t\t$s_km\t$d.$m.$y\n";
    } else {
	printf $fo "$shoes_name\t\t\t$s_km\t$d.$m.$y\n";
    }
    return;
}

# file
$dir  = "./";
$filename = "1000km_shoes.dat";


if (-e $dir.$filename) { 

    open(my $fh, '<:encoding(UTF-8)', $dir.$filename)
	or die "Could not open file '$filename' $!";

    while (my $row = <$fh>) {
	my @sline = split(' ', $row);
	
	$shoes = $sline[0]; # shoes
	$km    = $sline[1]; # km
	$today = $sline[2]; # date

	$run{$shoes} += $km;
    }

    print "Choose your shoes:\n";
    $n = 0;
    print "[0] Print out actual states & exit \n";
    foreach $key ( keys %run) {
	$n += 1;
	print "[$n] $key\n";
	push(@shoes_list, $key);
    }
    $n += 1;
    print "[$n] To enter new shoes\n";
    
    print "Please enter your selection: ";
    $s_shoes = <>;
    chomp $s_shoes;
    
    if ($s_shoes == $n) {
	print "Enter shoes name: ";
	$shoes_name = <>;
	chomp $shoes_name;
	print "Enter the distance (km) ran: ";
	$s_km = <>;
	chomp $s_km;
	$run{$shoes_name} += $s_km;
	
	# print output statisitc
	print_output;

	# write file
	write_file;

    } elsif ($s_shoes == 0) {
	print_output;
    } else {
	print "\nEnter the distance (km) ran by the shoes $shoes_list[$s_shoes-1]: ";
	$s_km = <>;
	chomp $s_km;

	$shoes_name = $shoes_list[$s_shoes-1];

	$run{$shoes_name} += $s_km;
	
	# print output statisitc
	print_output;
	
	# write file
	write_file;
    }

} else {
    print "The file $filename has been created\n";    
    
    print "Enter shoes name: ";
    $shoes_name = <>;
    chomp $shoes_name;
    print "Enter the distance (km) ran: ";
    $s_km = <>;
    chomp $s_km;
    $run{$shoes_name} += $s_km;
    
    # print output statisitc
    print_output;
    
    # write file
    write_file;
}

close $fh;
