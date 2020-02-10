package Entities::Rules;

use strict;
use warnings;
use Entities::Connector;

sub new {
    my $dbi = Entities::Connector -> new();

    $dbi -> create_model('pastebin_rule');

    my $rules = $dbi -> model('pastebin_rule') -> select(['ID_RULE', 'ID_COMPANY', 'WORD', 'FILTER']);
    my @data;

    while (my $rule = $rules -> fetch_hash) {
        push @data, {
            id => $rule -> {ID_RULE},
            idCompany => $rule -> {ID_COMPANY},
            word => $rule -> {WORD},
            filter => $rule -> {FILTER}
        };
    }

    return @data;
}

1;