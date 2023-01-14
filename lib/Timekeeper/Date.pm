package Timekeeper::Date;

use v5.28;
use warnings;
use autodie;

use Time::Piece;

use constant STR_FORMAT     => '%s-%s-%s %s:%s';
use constant DT_FORMAT      => '%Y-%m-%d %H:%M';
use constant ROUND_INTERVAL => 15;

sub Create {
    my $date = shift;

    my $timepiece = localtime;
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

1;
