#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Timekeeper::DB;
use Timekeeper::Date;

my $db = Timekeeper::DB->New();

$db->register_stop( Timekeeper::Date::Create() );

say 'Bye';

exit 0;
