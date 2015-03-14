#!/usr/bin/perl
use Time::localtime;
use Time::Local;
use POSIX qw(strftime);

# file
$dir  = "./";
$filename = "1000km_shoes.dat";

print "Please enter the year: ";
$s_year = <>;
chomp $s_year;

if (-e $dir.$filename) { 

    open(my $fh, '<:encoding(UTF-8)', $dir.$filename)
	or die "Could not open file '$filename' $!";

    while (my $row = <$fh>) {
	my @sline = split(' ', $row);
	
	$shoes = $sline[0]; # shoes
	$km    = $sline[1]; # km
	$today = $sline[2]; # date

	if ( substr($today, 6, 4) eq $s_year ) {
	$run{$shoes} += $km;
	push @{ $date{$shoes} }, $today;
	}
    }


} else {
    print "No data!\n" and exit; 
}


# print "Enter your name: ";
# $s_name = <>;
# chomp $s_name;


print "Select your shoes:\n";
$n = 0;
foreach $key ( keys %run) {
    $n += 1;
    print "[$n] $key\n";
    push(@shoes_list, $key);
}
print "Please enter your selection: ";
$s_shoes = <>;
chomp $s_shoes;

$shoes_name = $shoes_list[$s_shoes-1];

foreach $day ( @{ $date{$shoes_name} } ) {
    print "$day\n";
}


# my $date = '08/15/2012';
# my ($month, $day, $year) = split '/', $date;

# my $epoch = timelocal( 0, 0, 0, $day, $month - 1, $year - 1900 );
# my $week  = strftime( "%U", localtime( $epoch ) );

# printf "Date: %s № Week: %s\n", $date, $week;





