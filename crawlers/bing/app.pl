#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib q{./lib/};
use lib q{../lib/};
use Entities::Rules;
use Entities::Connector;
use Harpoon::Crawler::DetectionStore;
use Scraper::Collector;
use Digest::MD5 qw(md5_hex);

our $VERSION = '0.01';

sub main {
    my $database_handle = Entities::Connector -> new();

    if ($database_handle) {
        my $detection_store = Harpoon::Crawler::DetectionStore -> new($database_handle);
        $detection_store -> create_model('alert');

        my @rule_entries = Entities::Rules -> new();

        foreach my $rule_index (keys @rule_entries) {
            my $search_string = $rule_entries[$rule_index] -> {string};
            my $search_filter = $rule_entries[$rule_index] -> {filter};

            my @collected_urls = Scraper::Collector -> new($search_string, $search_filter);

            foreach my $url (@collected_urls) {
                my $md5_hash = md5_hex($url);

                if (!$detection_store -> record_exists('alert', 'HASH', $md5_hash)) {
                    my $insert_result = $detection_store -> insert_record('alert', {
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
