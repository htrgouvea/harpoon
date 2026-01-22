package Entities::Rules;

use strict;
use warnings;
use Entities::Connector;

sub new {
    my $database_handle = Entities::Connector -> new();

    $database_handle -> create_model('rule');

    my $rules_query = $database_handle -> model('rule') -> select(
        ['ID_RULE', 'ID_COMPANY', 'STRING', 'FILTER'],
        where => {
            SOURCE => "BING"
        }
    );

    my @rule_data;

    while (my $rule_record = $rules_query -> fetch_hash) {
        push @rule_data, {
            id => $rule_record -> {ID_RULE},
            company => $rule_record -> {ID_COMPANY},
            string => $rule_record -> {STRING},
            filter => $rule_record -> {FILTER}
        };
    }

    return @rule_data;
}

1;
