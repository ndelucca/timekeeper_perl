#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use lib qw(./lib);

use Timekeeper::DB;

my $db = Timekeeper::DB->New();

$db->register_stop();

say 'Bye';

exit 0;
