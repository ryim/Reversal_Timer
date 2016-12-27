#!/usr/bin/perl
#package placeholder;
#use Exporter qw(import);
#our @EXPORT_OK = qw(placeholder);
use warnings;
use strict;

sub num2ascii {
	my ($num) = @_;
    my @digits = split(//, $num);   # Treat each digit separately
    my $toprint = "";
    my %ascii;                      # Hash of arrays for art for each digit

    #   Grab relevant digits
    foreach my $digit (@digits) {
        next if $ascii{$digit};     # Skip if got already

        #   Slurp into hash of arrays
        open(my $fh, "$digit.txt");
        $/ = undef;
        @{$ascii{$digit}} = split(/\n/, <$fh>);
        close($fh);
    }

    #   Add ascii lines in order to make composite number
    for (my $line = 0; $line < 5; $line ++) {
        foreach my $digit (@digits) {
            $toprint = $toprint . "$ascii{$digit}[$line] ";
        }
        $toprint = $toprint . "\n";
    }

    #   Return the number
	return $toprint;
}

1;	# necessary for a module for some reason.
