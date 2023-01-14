package Timekeeper::DB;

use v5.28;
use warnings;
use autodie;

use DBI;
use Time::Piece;

sub New {
    my $class = shift;

    state $filename = 'timedb.sqlite';
    state $dbh      = DBI->connect( "dbi:SQLite:dbname=$filename", '', '' );

    my $self = bless { dbh => $dbh }, $class;

    return $self;
}

sub db {
    my $self = shift;
    return $self->{dbh};
}

sub initialize {
    my $self = shift;

    $self->db->do(
        q|CREATE TABLE IF NOT EXISTS times (
        id integer PRIMARY KEY AUTOINCREMENT NOT NULL,
        operation TEXT CHECK( operation IN ('IN','OUT') ) NOT NULL,
        date TEXT
    )|
    );

    return;
}

sub register {
    my $self      = shift;
    my $operation = shift;
    $self->db->do( q|INSERT INTO times (operation, date) VALUES (?,?)|,
        undef, $operation, localtime->datetime );
    return;
}

sub register_start {
    my $self = shift;
    $self->register('IN');
    return;
}

sub register_stop {
    my $self = shift;
    $self->register('OUT');
    return;
}

1;
