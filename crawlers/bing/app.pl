#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib "./lib/";
use Entities::Rules;
use Entities::Connector;
use Scraper::Collector;
use Digest::MD5 qw(md5_hex);

sub main {
    my $database_handle = Entities::Connector -> new();

    if ($database_handle) {
        $database_handle -> create_model('alert');

        my @rule_entries = Entities::Rules -> new();

        foreach my $rule_index (keys @rule_entries) {
            my $search_string = $rule_entries[$rule_index] -> {string};
            my $search_filter = $rule_entries[$rule_index] -> {filter};

            my @collected_urls = Scraper::Collector -> new($search_string, $search_filter);

            foreach my $url (@collected_urls) {
                my $md5_hash = md5_hex($url);

                my $existing_hash = eval {
                    $database_handle -> model('alert') -> select(
                        ['HASH'], where => { HASH => $md5_hash }
                    ) -> fetch -> [0]
                } || 1;

                if (length($existing_hash) == 1) {
                    my $insert_result = $database_handle -> model('alert') -> insert ({
                        ID_COMPANY => $rule_entries[$rule_index] -> {company},
                        CONTENT => $url,
                        STATUS => 0,
                        NOTIFICATION => 0,
                        HASH => $md5_hash
                    });
                }
            }
        }
    }
}

main();
exit;
