#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib "./lib/";
use Entities::Connector;
use Entities::Alerts;
use Worker::Dispatch;

sub main {
    my $dbi  = Entities::Connector -> DBI();

    if ($dbi) {
        my @alerts = Entities::Alerts -> new();

        foreach my $alert (@alerts) {
            my $dispatch = Worker::Dispatch -> new (
                $alert -> {id},
                $alert -> {idCompany},
                $alert -> {ref},
                $alert -> {content},
                $alert -> {date}
            );
        }
    }
}

main();
exit;