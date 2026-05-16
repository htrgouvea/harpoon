package Scraper::Collector;

our $VERSION = '0.01';

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

use constant HTTP_OK => 200;

sub new {
    my $endpoint  = q{http://scrape.pastebin.com/api_scraping.php?limit=250};
    my $user_agent = LWP::UserAgent -> new();
    my $response   = $user_agent -> get($endpoint);
    my $status_code  = $response -> code();

    if ($status_code == HTTP_OK) {
        my $data_entries = decode_json ($response -> content);

        my @keys;

        foreach my $entry (@{$data_entries}) {
            my $paste_key = $entry -> {'key'};
            push @keys, $paste_key;
        }

        return @keys;
    }
}

1;
