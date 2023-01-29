use v5.28;
use warnings;
use lib qw(./lib);

use Test::More tests => 1;
use Timekeeper::CLI;


my $columns = ['id', 'operation'];
my $rows = [[1,'IN'],[2,'OUT'],[3,'IN']];
my $expected = "+----+-----------+
| id | operation |
+----+-----------+
| 1  | IN        |
| 2  | OUT       |
| 3  | IN        |
+----+-----------+";

is( Timekeeper::CLI::DataAsTable($columns,$rows), $expected);

1;
