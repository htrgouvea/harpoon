package Entities::Rules;

use strict;
use warnings;
use Entities::Connector;

sub new {
    my $dbi = Entities::Connector -> new();

    $dbi -> create_model('rule');

    my $rules = $dbi -> model('rule') -> select(
        ['ID_RULE', 'ID_COMPANY', 'STRING', 'FILTER'],
        where => {
            SOURCE => "BING"
        }
    );

    my @data;

    while (my $rule = $rules -> fetch_hash) {
        push @data, {
            id => $rule -> {ID_BING_RULE},
            company => $rule -> {ID_COMPANY},
            string => $rule -> {STRING},
            filter => $rule -> {FILTER}
        };
    }

    return @data;
}

1;
