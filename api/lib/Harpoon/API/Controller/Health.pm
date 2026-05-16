package Harpoon::API::Controller::Health;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Harpoon::API::Controller::Base', -signatures;
use English qw(-no_match_vars);
use POSIX qw(strftime);
use Time::HiRes qw(time);

use constant MILLISECONDS_PER_SECOND => 1000;

sub status ($self) {
    my $pg = $self -> stash('pg');
    my $started_at = $self -> stash('started_at');

    my $uptime_now = time;

    eval {
        my $db = $pg -> db;
        $db -> query('SELECT 1');
        1;
    } or do {
        my $error = $EVAL_ERROR;
        my $message = q{};

        if (defined $error) {
            $message = "$error";
            $message =~ s/\s+$//msx;
        }

        return $self -> render(
            status => 503,
            json => {
                status => 'unhealthy',
                database => 'disconnected',
                error => $message
            }
        );
    };

    my $seconds = int $uptime_now;
    my $milliseconds = int (($uptime_now - $seconds) * MILLISECONDS_PER_SECOND);

    my $timestamp = strftime '%Y-%m-%dT%H:%M:%S', gmtime $seconds;
    $timestamp = sprintf '%s.%03dZ', $timestamp, $milliseconds;

    my $uptime = $uptime_now - $started_at;

    return $self -> render(
        status => 200,
        json => {
            status => 'healthy',
            database => 'connected',
            uptime => $uptime,
            timestamp => $timestamp
        }
    );
}

1;
