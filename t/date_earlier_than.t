use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 3;
use Timekeeper::Date;

my $now = Timekeeper::Date::Create();

is( Timekeeper::Date::EarlierThan( date => $now,               days => 2 ), 1 );
is( Timekeeper::Date::EarlierThan( date => '1999-11-19 02:36', days => 10 ), 0 );
is( Timekeeper::Date::EarlierThan( date => '2023-01-28 23:00', days => 1), 0 );

1;
