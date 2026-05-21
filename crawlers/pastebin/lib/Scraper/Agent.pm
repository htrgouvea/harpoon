package Scraper::Agent;

our $VERSION = '0.01';

use strict;
use warnings;
use Harpoon::Crawler::DetectionEngine;
use LWP::UserAgent;

use constant HTTP_OK => 200;

sub new {
    my ($self, $paste_key, $company_id, $keyword, $filters) = @_;

    my $endpoint  = "http://scrape.pastebin.com/api_scrape_item.php?i=$paste_key";
    my $user_agent = LWP::UserAgent -> new();
    my $response   = $user_agent -> get($endpoint);
    my $status_code  = $response -> code();

    if ($status_code == HTTP_OK) {
        my $data = $response -> content();

        if (Harpoon::Crawler::DetectionEngine -> matches_keyword_and_filters($data, $keyword, $filters)) {
            return uc $data;
        }
    }

    return q{false};
}

1;
