package Timekeeper::DB;

use v5.28;
use warnings;
use autodie;

use DBI;

sub New {
    my $class = shift;

    state $filename = '../timedb.sqlite';
    state $dbh      = DBI->connect( "dbi:SQLite:dbname=$filename", '', '' );

    return bless { dbh => $dbh }, $class;
}

1;
