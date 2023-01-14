use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 1;
use Timekeeper::DB;

my $db = Timekeeper::DB->New();

is( $db->{dbh}->selectrow_array('SELECT 2+2'), 4 );

1;
