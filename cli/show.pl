#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Timekeeper::DB;
use Timekeeper::CLI;
use Timekeeper::Date;

my $params = Timekeeper::CLI::ParseShowOptions();

my $db = Timekeeper::DB->New();

my @registers = @{ $db->fetch() };

if ( $params->{days} ) {
    @registers = grep {
        Timekeeper::Date::EarlierThan( date => $_->[2], days => $params->{days} )
    } @registers;
}

say Timekeeper::CLI::DataAsTable( Timekeeper::DB->ColNames(), \@registers );

exit 0;
