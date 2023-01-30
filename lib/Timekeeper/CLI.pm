package Timekeeper::CLI;

use v5.28;
use warnings;
use autodie;

use Getopt::Long ();
use Text::TabularDisplay;

sub ParseShowOptions {

    my $days = 0;
    my $raw;

    Getopt::Long::GetOptions(
        'd|days=i' => \$days,
        'r|raw'    => \$raw,
    );

    return {
        days => $days,
        raw  => $raw,
    };

}

sub DataAsTable {
    my $column_names = shift;
    my $rows         = shift;

    my $table = Text::TabularDisplay->new(@$column_names);

    $table->populate($rows);

    return $table->render;

}

1;

