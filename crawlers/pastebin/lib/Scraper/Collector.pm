package Scraper::Collector;

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

sub new {
    my $endpoint  = "http://scrape.pastebin.com/api_scraping.php?limit=250";
    my $user_agent = LWP::UserAgent -> new();
    my $response   = $user_agent -> get($endpoint);
    my $status_code  = $response -> code();

    if ($status_code == "200") {
        my $data_entries = decode_json ($response -> content);

        my @keys;

        foreach my $entry (@$data_entries) {
            my $paste_key = $entry -> {'key'};
            push @keys, $paste_key;
        }

        return @keys;
    }
}

1;
