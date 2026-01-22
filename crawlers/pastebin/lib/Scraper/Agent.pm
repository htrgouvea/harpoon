package Scraper::Agent;

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

sub new {
    my ($self, $paste_key, $company_id, $keyword, $filters) = @_;

    my $endpoint  = "http://scrape.pastebin.com/api_scrape_item.php?i=$paste_key";
    my $user_agent = LWP::UserAgent -> new();
    my $response   = $user_agent -> get($endpoint);
    my $status_code  = $response -> code();

    my @filter_rules = split(' / ', $filters);

    if ($status_code == "200") {
        my $data = uc $response -> content(); 

        $keyword = uc $keyword;

        if (($data =~ m/$keyword/) && (map { $data =~ /$_/i } @filter_rules)) {
            return $data;
        }
    }

    return "false";
}

1;
