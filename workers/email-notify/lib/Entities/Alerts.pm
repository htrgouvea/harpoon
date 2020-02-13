package Entities::Alerts;

use strict;
use warnings;

sub new {
    my $dbi = Entities::Connector -> DBI();

    $dbi -> create_model('pastebin_alert');

    my $alerts = $dbi -> model('pastebin_alert') -> select([
        'ID_PASTEBIN_ALERT',
        'ID_COMPANY',
        'CONTENT',
        'DATETIME', 
        'REF'
    ], where => {STATUS => 0});
    
    my @data;

    while (my $alert = $alerts -> fetch_hash) {
        push @data, {
            id => $alert -> {ID_PASTEBIN_ALERT},
            idCompany => $alert -> {ID_COMPANY},
            content => $alert -> {CONTENT},
            date => $alert -> {DATETIME},
            ref => $alert -> {REF}
        };
    }

    return @data;
}

1;