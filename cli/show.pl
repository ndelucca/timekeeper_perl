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

    if ( $params->{raw} ) {
        say Timekeeper::CLI::DataAsTable( Timekeeper::DB->ColNames(), \@registers );
        return;
    }

    my %days = group_by_day(@registers);

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

sub group_by_day {
    my @registers = @_;

    my %days = ();

    for my $register (@registers) {
        my ( $id, $operation, $date ) = @$register;

        my $day = Timekeeper::Date::CompressedDate($date);

        $days{$day}->{$operation} = [] unless $days{$day}->{$operation};
        push @{ $days{$day}->{$operation} }, $date;
    }

    return %days;
}
