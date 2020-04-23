#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib "./lib/";
use Worker::Dispatch;
use Entities::Alerts;
use Entities::Company;
use Entities::Connector;

sub main {
    my $dbi = Entities::Connector -> DBI();

    if ($dbi) {
        my @alerts = Entities::Alerts -> new();

        foreach my $alert (@alerts) {
            my %company = Entities::Company -> new($alert -> {company});

            my $worker = Worker::Dispatch -> new (
                $alert -> {id},
                $alert -> {company},
                $alert -> {content},
                $alert -> {date},
                $company{name},
                $company{email}
            );

            my $updateNotification = Entities::Alerts -> updateNotification($alert -> {id}); 
        }
    }
}

main();
exit;