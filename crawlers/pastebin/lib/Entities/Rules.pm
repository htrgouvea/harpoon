package Entities::Rules;

use strict;
use warnings;
use Entities::Connector;

sub new {
    my $database_handle = Entities::Connector -> new();

    $database_handle -> create_model('pastebin_rule');

    my $rules_query = $database_handle -> model('pastebin_rule') -> select(['ID_RULE', 'ID_COMPANY', 'WORD', 'FILTER']);
    my @rule_data;

    while (my $rule_record = $rules_query -> fetch_hash) {
        push @rule_data, {
            id => $rule_record -> {ID_RULE},
            company_id => $rule_record -> {ID_COMPANY},
            word => $rule_record -> {WORD},
            filter => $rule_record -> {FILTER}
        };
    }

    return @rule_data;
}

1;
