package Timekeeper::CLI;

use v5.28;
use warnings;
use autodie;

use Getopt::Long ();
use Text::TabularDisplay;

use Timekeeper::Date;

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

sub DaysAsTable {
    my %days = @_;

    my $table = Text::TabularDisplay->new( 'day', 'in', 'out', 'hours' );

    for my $day ( keys %days ) {
        my $current = Timekeeper::Date::CompressedDate( $days{$day}{in} );
        my $in      = $days{$day}{in};
        my $out     = $days{$day}{out};

        my $seconds = Timekeeper::Date::ToTimePiece($out) -
          Timekeeper::Date::ToTimePiece($in);
        my $hours = $seconds / 60 / 60;

        $table->add($current, $in, $out, $hours);
    }

    return $table->render;
}

1;

