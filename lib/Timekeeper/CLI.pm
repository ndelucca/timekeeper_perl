package Timekeeper::CLI;

use v5.28;
use warnings;
use autodie;

use Getopt::Long ();
use Text::TabularDisplay;

sub ParseShowOptions {

    my $days = 0;

    Getopt::Long::GetOptions(
        "d|days=i" => \$days,
    );

    return { days => $days };

}

sub DataAsTable {
    my $column_names = shift;
    my $rows         = shift;

    my $table = Text::TabularDisplay->new(@$column_names);

    $table->populate($rows);

    return $table->render;

}

1;

