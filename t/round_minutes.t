use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 8;
use Timekeeper::Utils;

is(Timekeeper::Utils->RoundMinutes(0),0);
is(Timekeeper::Utils->RoundMinutes(1),0);
is(Timekeeper::Utils->RoundMinutes(15),15);
is(Timekeeper::Utils->RoundMinutes(16),15);
is(Timekeeper::Utils->RoundMinutes(30),30);
is(Timekeeper::Utils->RoundMinutes(31),30);
is(Timekeeper::Utils->RoundMinutes(45),45);
is(Timekeeper::Utils->RoundMinutes(46),45);

1;
