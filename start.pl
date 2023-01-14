#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use lib qw(./lib);

use Timekeeper::DB;
use Timekeeper::Date;

my $db = Timekeeper::DB->New();

$db->register_start( Timekeeper::Date::Create() );

say 'Welcome';

exit 0;
