package Timekeeper::DB;

use v5.28;
use warnings;
use autodie;

use DBI;
use Timekeeper::Date;

my %conf = (
    dbname     => 'timedb.sqlite',
    table_name => 'times'
);

sub New {
    my $class = shift;

    state $dbh = DBI->connect( "dbi:SQLite:dbname=$conf{dbname}", '', '' );

    my $self = bless { dbh => $dbh }, $class;

    $self->initialize();

    return $self;
}

sub db {
    my $self = shift;
    return $self->{dbh};
}

sub initialize {
    my $self = shift;

    $self->db->do(
        qq|CREATE TABLE IF NOT EXISTS times (
        id integer PRIMARY KEY AUTOINCREMENT NOT NULL,
        operation TEXT CHECK( operation IN ('IN','OUT') ) NOT NULL,
        date TEXT
    )|
    );

    return;
}

sub fetch {
    my $self = shift;
    my %args = (
        limit => 20,
        @_,
    );

    my $options = '';
    if ( $args{limit} ) {
        $options .= qq|LIMIT $args{limit}|;
    }

    my $results = $self->db->selectall_arrayref(qq|SELECT operation, date FROM $conf{table_name} $options|);

    return $results;
}

sub register {
    my $self      = shift;
    my $operation = shift;
    $self->db->do(
        qq|INSERT INTO $conf{table_name} (operation, date) VALUES (?,?)|,
        undef, $operation, Timekeeper::Date::Create() );
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

sub clear_registers {
    my $self = shift;
    $self->db->do(qq|DROP TABLE $conf{table_name}|);
}

1;
