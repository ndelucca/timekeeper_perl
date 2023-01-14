#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use lib qw(./lib);

use Timekeeper::DB;

my $db = Timekeeper::DB->New();

$db->clear_registers();

say 'cleared';

exit 0;
