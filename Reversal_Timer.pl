#!/usr/bin/perl
use warnings;
use strict;
use FindBin;
use lib $FindBin::Bin;
use num2ascii;

#   User defined variables
my $holdtime = 16;      # Time to hold at full draw
my $stoptime = 20;      # Time resting within a set
my $setwait = 35;       # Time resting between sets (added to stop time)
my $setnum = 5;         # number of full draw holds within a set

#   Global variables - do not touch!
my $holdcount = 0;

#   Lead-up
countdown(5, "GetReady.txt", 1);

#   Hold, rest, setrest
while (42) {    # infinite loop. If you don't know why "42", look it up
    my $setcount = $setnum;
    until ($setcount == 0) {             # Loop through each hold in the set
        countdown($holdtime, "Start.txt", 1);
        $holdcount ++;                                      # Add to counter
        countdown($stoptime, "Stop2.txt", 1);
        $setcount --;
    }
    countdown($setwait, "Set.txt", 1);
}

###############################################################################
#   Subroutines

#   Clear screen and print number of holds done
sub screenwipe {
    system("printf \"\\033c\"");
    my $timeafd = $holdcount * $holdtime;
    print "Reversals with form master: $holdcount\n"
         ."Per reversal: $holdtime sec hold, $stoptime sec rest\n"
         ."Extra rest: $setwait sec every $setnum reversals\n"
         ."Time at full draw: $timeafd sec.\n\n";
}

#   Countdown
sub countdown {
    my ($countlength, $file, $beep) = @_;
    for (my $time = $countlength; $time > 0; $time --) {        # set interval
        screenwipe();
        system("cat $file; echo");
        print num2ascii($time);
        if ($time == 1 && $beep == 1) {
            system("paplay beep-01a.wav");
        } else {
            sleep(1);
        }
    }
}
