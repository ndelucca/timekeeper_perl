package Timekeeper::Date;

use v5.28;
use warnings;
use autodie;

use Time::Piece     ();
use List::MoreUtils qw(zip_unflatten);

use constant STR_FORMAT     => '%s-%s-%s %s:%s';
use constant DT_FORMAT      => '%Y-%m-%d %H:%M';
use constant ROUND_INTERVAL => 15;

sub Create {
    my $date = shift;

    my $timepiece = Time::Piece::localtime;
    $timepiece = ToTimePiece($date) if $date;

    return ToTimekeepingTimePiece($timepiece)->strftime(DT_FORMAT);
}

sub RoundMinutes {
    my $minutes = shift;
    return ROUND_INTERVAL * int( $minutes / ROUND_INTERVAL );
}

sub ToTimePiece {
    my $date_str = shift;
    return Time::Piece->strptime( $date_str, DT_FORMAT );
}

sub ToTimekeepingTimePiece {
    my $timepiece = shift;

    my ( $year, $month,  $day )    = split '-', $timepiece->ymd();
    my ( $hour, $minute, $second ) = split ':', $timepiece->hms();

    $minute = RoundMinutes($minute);

    my $strdate = sprintf STR_FORMAT, $year, $month, $day, $hour, $minute;

    return Time::Piece->strptime( $strdate, DT_FORMAT );

}

sub EarlierThan {
    my %args = @_;

    my $seconds = $args{days} * 24 * 60 * 60;
    my $date    = ToTimePiece( $args{date} );
    my $now     = Time::Piece::localtime;

    my $diff = $now - $date;

    return $diff > $seconds ? 0 : 1;

}

sub CompressedDate {
    my $date_str = shift;
    my $date     = ToTimePiece($date_str)->ymd();
    $date =~ s/-//gi;
    return $date;
}

sub Simplify {
    my $checkins  = shift;
    my $checkouts = shift;

    my $init = shift @$checkins;
    my $end  = ToTimePiece( shift @$checkouts );

    for my $pair ( zip_unflatten( @$checkins, @$checkouts ) ) {
        my ( $in, $out ) = @$pair;

        my $tk_in  = ToTimePiece($in);
        my $tk_out = ToTimePiece($out);

        my $diff = $tk_out - $tk_in;

        $end += $diff;

    }

    $end = ToTimekeepingTimePiece($end)->strftime(DT_FORMAT);

    return {
        in  => $init,
        out => $end,
    };

}

1;
