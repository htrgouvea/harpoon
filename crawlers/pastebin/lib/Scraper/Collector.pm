package Scraper::Collector;

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

sub new {
    my $endpoint  = "http://scrape.pastebin.com/api_scraping.php?limit=250";
    my $userAgent = LWP::UserAgent -> new();
    my $request   = $userAgent -> get($endpoint);
    my $httpCode  = $request -> code();

    if ($httpCode == "200") {
        my $datas = decode_json ($request -> content);

        my @keys;

        foreach my $data (@$datas) {
            my $key = $data -> {'key'};
            push @keys, $key;
        }

        return @keys;
    }
}

1;