package Entities::Rules;

use strict;
use warnings;
use Entities::Connector;

sub new {
    my $dbi = Entities::Connector -> new();

    $dbi -> create_model('bing_rule');

    my $rules = $dbi -> model('bing_rule') -> select(['ID_BING_RULE', 'ID_COMPANY', 'DOMAIN']);
    my @data;

    while (my $rule = $rules -> fetch_hash) {
        push @data, {
            id => $rule -> {ID_BING_RULE},
            idCompany => $rule -> {ID_COMPANY},
            domain => $rule -> {DOMAIN}
        };
    }

    return @data;
}

1;
