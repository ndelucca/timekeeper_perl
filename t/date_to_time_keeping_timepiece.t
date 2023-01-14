use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 3;
use Timekeeper::Date;

my $tp1 = Timekeeper::Date::ToTimePiece('2023-12-10 17:29');
isa_ok($tp1, 'Time::Piece');
is( Timekeeper::Date::ToTimekeepingTimePiece($tp1)->ymd, '2023-12-10' );
is( Timekeeper::Date::ToTimekeepingTimePiece($tp1)->hms, '17:15:00' );

1;
