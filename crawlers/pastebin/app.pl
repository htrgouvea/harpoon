#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib "./lib/";
use Entities::Connector;
use Entities::Rules;
use Scraper::Agent;
use Scraper::Collector;

sub main {
    my $database_handle = Entities::Connector -> new();

    if ($database_handle) {
        $database_handle -> create_model('pastebin_alert');
        $database_handle -> create_model('pastebin_history');

        my @rule_entries = Entities::Rules -> new();
        my @paste_keys = Scraper::Collector -> new();

        foreach my $paste_key (@paste_keys) {
            my $history_record = eval {$database_handle -> model('pastebin_history') -> select(
                ['REF'], where => {REF => $paste_key}
            ) -> fetch -> [0]} || 1;

            print "[+] -> $paste_key\n";

            if ($history_record eq "1") {
                foreach my $rule_index (keys @rule_entries) {
                    my $agent_result = Scraper::Agent -> new (
                        $paste_key,
                        $rule_entries[$rule_index] -> {company_id},
                        $rule_entries[$rule_index] -> {word},
                        $rule_entries[$rule_index] -> {filter}
                    );

                    if ($agent_result ne "false") {
                        my $insert_result = $database_handle -> model('pastebin_alert') -> insert ({
                            ID_COMPANY => $rule_entries[$rule_index] -> {company_id},
                            CONTENT => $agent_result,
                            STATUS => 0,
                            NOTIFICATION => 0,
                            REF => $paste_key
                        });
                    }
                }
                
                my $insert_result = $database_handle -> model('pastebin_history') -> insert({REF => $paste_key});
            }
        }
    }
}

main();
exit;
