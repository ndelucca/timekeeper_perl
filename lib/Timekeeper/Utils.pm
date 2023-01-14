package Timekeeper::Utils;

use v5.28;
use warnings;
use autodie;

sub RoundMinutes {
    my $class   = shift;
    my $minutes = shift;
    my $interval = shift || 15;

    return $interval * int( $minutes / $interval );
}

1;
