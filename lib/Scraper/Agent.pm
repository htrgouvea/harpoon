#!/usr/bin/env perl

package Scraper::Agent;

use JSON;
use LWP::UserAgent;

sub new {
    my ($self, $key, $idCompany, $word, $filters) = @_;

    my $endpoint  = "http://scrape.pastebin.com/api_scrape_item.php?i=$key";
    my $userAgent = LWP::UserAgent -> new();
    my $request   = $userAgent -> get($endpoint);
    my $httpCode  = $request -> code();

    my @rules = split(' / ', $filters);

    if ($httpCode == "200") {
        my $data = uc $request -> content();        
        
        if (($data =~ m/$word/) && (map { $data =~ /$_/i } @rules)) {
            return $data;
        }
    }

    return false;
}

1;