use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 8;
use Timekeeper::Date;

is(Timekeeper::Date::RoundMinutes(0),0);
is(Timekeeper::Date::RoundMinutes(1),0);
is(Timekeeper::Date::RoundMinutes(15),15);
is(Timekeeper::Date::RoundMinutes(16),15);
is(Timekeeper::Date::RoundMinutes(30),30);
is(Timekeeper::Date::RoundMinutes(31),30);
is(Timekeeper::Date::RoundMinutes(45),45);
is(Timekeeper::Date::RoundMinutes(46),45);

1;
