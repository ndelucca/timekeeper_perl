#!/usr/bin/perl

use v5.28;
use warnings;
use autodie;

use FindBin;
use lib "$FindBin::Bin/lib";

use Timekeeper::DB;

my $db = Timekeeper::DB->New();

my $registers = $db->fetch();

for my $register ( @$registers ) {
    say join ' ', @$register;
}

exit 0;
