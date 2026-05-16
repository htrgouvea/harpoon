#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib q{./lib/};
use Entities::Rules;
use Entities::Connector;
use Scraper::Collector;
use Digest::MD5 qw(md5_hex);

our $VERSION = '0.01';

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

                my $alert_model = $database_handle -> model('alert');
                my $hash_query = $alert_model -> select(
                    ['HASH'], where => { HASH => $md5_hash }
                );
                my $hash_row = $hash_query -> fetch;
                my $existing_hash = 1;
                if ($hash_row) {
                    $existing_hash = $hash_row -> [0] || 1;
                }

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

    return 0;
}

exit main();
