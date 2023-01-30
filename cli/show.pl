#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Timekeeper::DB;
use Timekeeper::CLI;
use Timekeeper::Date;

show();

exit 0;

sub show {

    my $params = Timekeeper::CLI::ParseShowOptions();

    my $db = Timekeeper::DB->New();

    my @registers = @{ $db->fetch() };

    @registers = grep { days_filter( $_, $params ) } @registers;

    say Timekeeper::CLI::DataAsTable( Timekeeper::DB->ColNames(), \@registers );

    return;
}

sub days_filter {
    my $register = shift;
    my $params   = shift;

    return 1 unless $params->{days};

    return Timekeeper::Date::EarlierThan(
        date => $register->[2],
        days => $params->{days}
    );
}
