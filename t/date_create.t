use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 2;
use Timekeeper::Date;

is( Timekeeper::Date::Create('2023-01-10 17:15'), '2023-01-10 17:15' );
is( Timekeeper::Date::Create('1999-11-19 02:36'), '1999-11-19 02:30' );

1;
