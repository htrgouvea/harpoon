#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib q{./lib/};
use lib q{../lib/};
use Entities::Connector;
use Entities::Rules;
use Harpoon::Crawler::DetectionStore;
use Scraper::Agent;
use Scraper::Collector;

our $VERSION = '0.01';

sub main {
    my $database_handle = Entities::Connector -> new();

    if ($database_handle) {
        my $detection_store = Harpoon::Crawler::DetectionStore -> new($database_handle);
        $detection_store -> create_model('pastebin_alert');
        $detection_store -> create_model('pastebin_history');

        my @rule_entries = Entities::Rules -> new();
        my @paste_keys = Scraper::Collector -> new();

        foreach my $paste_key (@paste_keys) {
            print "[+] -> $paste_key\n";

            if (!$detection_store -> record_exists('pastebin_history', 'REF', $paste_key)) {
                foreach my $rule_index (keys @rule_entries) {
                    my $agent_result = Scraper::Agent -> new (
                        $paste_key,
                        $rule_entries[$rule_index] -> {company_id},
                        $rule_entries[$rule_index] -> {word},
                        $rule_entries[$rule_index] -> {filter}
                    );

                    if ($agent_result ne q{false}) {
                        my $insert_result = $detection_store -> insert_record('pastebin_alert', {
                            ID_COMPANY => $rule_entries[$rule_index] -> {company_id},
                            CONTENT => $agent_result,
                            STATUS => 0,
                            NOTIFICATION => 0,
                            REF => $paste_key
                        });
                    }
                }

                my $insert_result = $detection_store -> insert_record('pastebin_history', {REF => $paste_key});
            }
        }
    }

    return 0;
}

exit main();
