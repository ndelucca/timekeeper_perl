package Timekeeper::DB;

use v5.28;
use warnings;
use autodie;

use DBI;
use FindBin;

my %conf = (
    dbname       => "$FindBin::Bin/../timedb.sqlite",
    table_name   => 'times',
    column_names => [ 'id', 'operation', 'date' ],
);

sub ColNames {
    return $conf{column_names};
}

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
        qq|CREATE TABLE IF NOT EXISTS $conf{table_name} (
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

    my $results = $self->db->selectall_arrayref(
        qq|SELECT id, operation, date FROM $conf{table_name} $options|);

    return $results;
}

sub register {
    my $self      = shift;
    my $operation = shift;
    my $datetime  = shift;
    $self->db->do(
        qq|INSERT INTO $conf{table_name} (operation, date) VALUES (?,?)|,
        undef, $operation, $datetime );
    return;
}

sub register_start {
    my $self     = shift;
    my $datetime = shift;
    $self->register( 'IN', $datetime );
    return;
}

sub register_stop {
    my $self     = shift;
    my $datetime = shift;
    $self->register( 'OUT', $datetime );
    return;
}

sub clear_registers {
    my $self = shift;
    $self->db->do(qq|DROP TABLE $conf{table_name}|);
}

1;
