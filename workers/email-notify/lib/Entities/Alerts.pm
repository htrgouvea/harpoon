package Entities::Alerts;

use strict;
use warnings;
use Entities::Connector;

my $dbi = Entities::Connector -> DBI();
$dbi -> create_model('alert');

sub new {
    my $alerts = $dbi -> model('alert') -> select([
        'ID_ALERT',
        'ID_COMPANY',
        'CONTENT',
        'DATETIME', 
        'HASH'
    ], where => {NOTIFICATION => 0});
    
    my @data;

    while (my $alert = $alerts -> fetch_hash) {
        push @data, {
            id => $alert -> {ID_ALERT},
            company => $alert -> {ID_COMPANY},
            content => $alert -> {CONTENT},
            date => $alert -> {DATETIME},
            hash => $alert -> {HASH}
        };
    }

    return @data;
}

sub updateNotification {
    my ($self, $id) = @_;

    my $alert = $dbi -> update(
        {NOTIFICATION => "1"}, table  => "alert", where  => {ID_ALERT => $id}
    );

    return 1;
}

1;